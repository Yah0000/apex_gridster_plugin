var gridster;

function drawGridster(dataIn, gridsterIn) {
	var serialization = Gridster.sort_by_row_and_col_asc(dataIn);
	gridsterIn.remove_all_widgets();

	serialization.forEach(function (entry) {

		gridsterIn.add_widget('<li class="t-Region t-Region--showIcon t-Region--scrollBody " id="' + entry.id + '">'
			+ ' <div class="t-Region-header container">'
			+ '  <div class="t-Region-headerItems t-Region-headerItems--title">'
			+ (entry.image !== undefined ? '    <span class="t-Region-headerIcon"><span class="t-Icon fa ' + entry.image + '" aria-hidden="true"></span></span>' : "")
			+ '    <h2 class="t-Region-title">' + entry.title + '</h2>'
			+ '  </div>'
			+ '  <div class="t-Region-headerItems t-Region-headerItems--buttons"><span class="js-maximizeButtonContainer"></span></div>'
			+ ' </div>'
			+ ' <div class="t-Region-bodyWrap">'
			+ '   <div class="t-Region-buttons t-Region-buttons--top">'
			+ '    <div class="t-Region-buttons-left"></div>'
			+ '    <div class="t-Region-buttons-right"></div>'
			+ '   </div>'
			+ '   <div class="t-Region-body">'
			+ '     ' + entry.content + '     '
			+ '   </div>'
			+ '   <div class="t-Region-buttons t-Region-buttons--bottom">'
			+ '    <div class="t-Region-buttons-left"></div>'
			+ '    <div class="t-Region-buttons-right"></div>'
			+ '   </div>'
			+ ' </div>'
			+ '</li>'
			, entry.size_x, entry.size_y, entry.col, entry.row);
	});

}

function saveLocalStorage(value_to_save) {

	var localStorage = apex.storage.getScopedLocalStorage({
		prefix: "PLUGIN_SETTINGS",
		useAppId: true
	});

	localStorage.setItem("Report_Dlist", value_to_save);
}

function readLocalStorage() {
	var localStorage = apex.storage.getScopedLocalStorage({
		prefix: "PLUGIN_SETTINGS",
		useAppId: true
	});
	return localStorage.getItem("Report_Dlist");
}
//******************************************************** */
var ajax_identifier, region_static_id;
var saveButton = document.querySelector(".gridster > .buttons > button");


function onLoadFn(l_ajax_identifier, region_static_id, l_allow_to_relocate, l_position_store_mode, l_item_pos_src, l_default_pos_src) {
	
	ajax_identifier = l_ajax_identifier;
	gridster = $("#" + region_static_id + " .gridster ul").gridster({
		widget_base_dimensions: [125, 125],
		widget_margins: [5, 5],
		autogrow_cols: true,
		resize: {
			enabled: (l_allow_to_relocate == 'Y') ? true : false
		},
		draggable: {
			stop: function (event, ui) {
			}
		},
		serialize_params: function ($w, wgd) {
			return {
				id: $w.attr('id'),
				col: wgd.col,
				row: wgd.row,
				size_x: wgd.size_x,
				size_y: wgd.size_y,
				html: $w.find('id').val()
			};
		},
	}).data("gridster");

	gridster.position_store_mode = l_position_store_mode;
	gridster.item_pos_src = l_item_pos_src;
	gridster.default_position_src = l_default_pos_src;

	if (l_allow_to_relocate != 'Y') {
		gridster.disable();
	}

	ReloadGridster(gridster, l_ajax_identifier);

	apex.region.create(region_static_id, {
		type: "region",
		refresh: function () {
			ReloadGridster(gridster, l_ajax_identifier);
		}
	});

	if (saveButton !== undefined && saveButton !== null) {
		saveButton.onclick = function () {
			SavePositions();
			apex.message.showPageSuccess("Changes saved!");
			apex.event.trigger(document, 'savelayout');

			apex.jQuery("#" + region_static_id).trigger("savelayout", {});
		};
	}
}

function ReloadGridster(gridsterIn, l_ajax_identifier) {

	apex.server.plugin(l_ajax_identifier, {}, {
		dataType: "text",
		success: function (data) {
			var gridster_data = JSON.parse(data);
			var grid_data = gridster_data.grid_data;
			var layout_data, layout_data_JSON;

			if (gridster.default_position_src === 'JSON') {

				let op = grid_data.map((e, i) => {
					let temp = gridster_data.grid_locations.find(element => element.id === e.id)
					if (temp !== undefined) {
						e.size_x = (temp.size_x === undefined) ? e.size_x : temp.size_x;
						e.size_y = (temp.size_y === undefined) ? e.size_y : temp.size_y;
						e.col = (temp.col === undefined) ? e.col : temp.col;
						e.row = (temp.row === undefined) ? e.row : temp.row;
					} else {
						e.size_x = 1;
						e.size_y = 1;
						e.col = 1;
						e.row = 1;
					}
					return e;
				})
			}

			switch (gridsterIn.position_store_mode) {
				case 'LOCAL_STORAGE':
					layout_data_JSON = readLocalStorage();
					break;
				case 'APEX_ITEM':
					layout_data_JSON = apex.item(gridster.item_pos_src).getValue();
					break;
				case 'APEX_COLLECTION':
					break;
			}

			try {
				layout_data = JSON.parse(layout_data_JSON);
			} catch (e) {
				layout_data = null;
			}

			if (layout_data && layout_data !== undefined) {

				let op = grid_data.map((e, i) => {
					let temp = layout_data.find(element => element.id === e.id)
					if (temp !== undefined) {
						e.size_x = (temp.size_x === undefined) ? e.size_x : temp.size_x;
						e.size_y = (temp.size_y === undefined) ? e.size_y : temp.size_y;
						e.col = (temp.col === undefined) ? e.col : temp.col;
						e.row = (temp.row === undefined) ? e.row : temp.row;
					}
					return e;
				})

			}
			drawGridster(gridster_data.grid_data, gridsterIn);
		}
	});

}

function SavePositions() {

	var serializeJsonArr = new Array();

	$(".gridster ul li").each(function (i) {
		var serializeJson = {};
		var id = $(this).attr('id');
		var row = $(this).attr('data-row');
		var col = $(this).attr('data-col');
		var sizex = $(this).attr('data-sizex');
		var sizey = $(this).attr('data-sizey');

		serializeJson["id"] = parseInt(id);
		serializeJson["row"] = parseInt(row);
		serializeJson["col"] = parseInt(col);
		serializeJson["size_x"] = parseInt(sizex);
		serializeJson["size_y"] = parseInt(sizey);

		serializeJsonArr.push(serializeJson);
	});

	switch (gridster.position_store_mode) {
		case 'LOCAL_STORAGE':
			saveLocalStorage(JSON.stringify(serializeJsonArr));
			break;
		case 'APEX_ITEM':
			apex.item(gridster.item_pos_src).setValue(JSON.stringify(serializeJsonArr));
			break;
		case 'APEX_COLLECTION':
			break;
	}

}