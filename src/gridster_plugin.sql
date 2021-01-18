 FUNCTION render_plugin (
        p_region               IN  apex_plugin.t_region,
        p_plugin               IN  apex_plugin.t_plugin,
        p_is_printer_friendly  IN  BOOLEAN
    ) RETURN apex_plugin.t_region_render_result IS

        l_ajax_identifier        VARCHAR2(255) := apex_plugin.get_ajax_identifier;
        v_no_data_found_message  VARCHAR2(255) := p_region.no_data_found_message;
        vr_result                apex_plugin.t_region_render_result;
        c_region_static_id       CONSTANT VARCHAR2(300) := p_region.static_id;
    

        c_height                 CONSTANT VARCHAR2(10) := nvl(p_region.attribute_11,'500px');
        c_save_button            CONSTANT VARCHAR(200) := apex_escape.html(nvl(p_region.attribute_15, 'Save layout'));
        c_position_store_mode    CONSTANT VARCHAR(200) := p_region.attribute_16;
        c_allow_to_relocate      CONSTANT VARCHAR(200) := p_region.attribute_14;
        c_default_color          CONSTANT VARCHAR(200) := p_region.attribute_12;
        c_item_pos_src           CONSTANT VARCHAR(200) := p_region.attribute_17;
        c_default_pos_src        CONSTANT VARCHAR(200) := p_region.attribute_05;
        c_default_font_color     CONSTANT VARCHAR(200) := p_region.attribute_13;
    BEGIN
        htp.style('
      .gridster .container {
        background-color: '
                  || c_default_color
                  || '; 
        color: '
                  || c_default_font_color
                  || ';
    }');

        htp.p('<div class="gridster">');
        IF (
            c_allow_to_relocate = 'Y'
            AND c_position_store_mode IS NOT NULL
        ) THEN
            htp.p('<div class="buttons"><button type="button" class="t-Button t-Button--icon t-Button--hot t-Button--iconLeft"><span aria-hidden="true" class="t-Icon t-Icon--left fa fa-save"></span>'
                  || c_save_button
                  || '</button></div>');
        END IF;

        htp.p('<ul>                  
            </ul>         
            </div>');
        apex_javascript.add_onload_code(' onLoadFn("'
                                        || l_ajax_identifier
                                        || '", "'
                                        || c_region_static_id
                                        || '" ,"'
                                        || c_allow_to_relocate
                                        || '","'
                                        || c_position_store_mode
                                        || '","'
                                        || c_item_pos_src
                                        || '", "'
                                        || c_default_pos_src
                                        || '");');

        RETURN vr_result;
    END;

    FUNCTION load_plugin (
        p_region  IN  apex_plugin.t_region,
        p_plugin  IN  apex_plugin.t_plugin
    ) RETURN apex_plugin.t_region_ajax_result IS

        l_return               apex_plugin.t_region_ajax_result;
        l_rows_count           NUMBER;      
        c_position_store_mode  CONSTANT VARCHAR(200) := p_region.attribute_16;
        c_allow_to_relocate    CONSTANT VARCHAR(200) := p_region.attribute_14;
        c_item_pos_src         CONSTANT VARCHAR(200) := p_region.attribute_17;
        c_default_pos_src      CONSTANT VARCHAR(200) := p_region.attribute_05;
        c_default_pos_json     CONSTANT CLOB := p_region.attribute_10;
        l_context              apex_exec.t_context;
        l_columns              apex_exec.t_columns;
        l_idx                  PLS_INTEGER := 0;
        l_id_col_idx           PLS_INTEGER;
        l_header_col_idx       PLS_INTEGER;
        l_content_col_idx      PLS_INTEGER;
        l_image_col_idx        PLS_INTEGER;
        l_region_column_idx    PLS_INTEGER;
        l_region_row_idx       PLS_INTEGER;
        l_region_xsize_idx     PLS_INTEGER;
        l_region_ysize_idx     PLS_INTEGER;
        l_values               apex_json.t_values;
        l_row_found            BOOLEAN;
    BEGIN
    
        l_context := apex_exec.open_query_context(p_columns => l_columns);
        l_id_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_01);

        l_header_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_02);

        l_content_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_03);

        l_image_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_04);

        CASE c_default_pos_src
            WHEN 'COLUMNS' THEN
                IF p_region.attribute_06 IS NOT NULL THEN
                    l_region_column_idx := apex_exec.get_column_position(p_context => l_context,
                                                                    p_column_name => p_region.attribute_06);
                END IF;

                IF p_region.attribute_07 IS NOT NULL THEN
                    l_region_row_idx := apex_exec.get_column_position(p_context => l_context,
                                                                    p_column_name => p_region.attribute_07);

                END IF;

                IF p_region.attribute_08 IS NOT NULL THEN
                    l_region_xsize_idx := apex_exec.get_column_position(p_context => l_context,
                                                                    p_column_name => p_region.attribute_08);
                END IF;

                IF p_region.attribute_09 IS NOT NULL THEN
                    l_region_ysize_idx := apex_exec.get_column_position(p_context => l_context,
                                                                    p_column_name => p_region.attribute_09);
                END IF;

            ELSE
                NULL;
        END CASE;

        l_rows_count := apex_exec.get_total_row_count(l_context);
        apex_json.open_object;
        apex_json.write(p_name => 'success', p_value => true);
        IF c_default_pos_src = 'JSON' THEN
            apex_json.parse(p_values => l_values, p_source => c_default_pos_json);
            apex_json.write('grid_locations', l_values);
        END IF;

        apex_json.open_array(p_name => 'grid_data');
        WHILE apex_exec.next_row(p_context => l_context) LOOP
            apex_json.open_object;
            apex_json.write(p_name => 'id', p_value => apex_exec.get_number(p_context => l_context, p_column_idx => l_id_col_idx));

            apex_json.write(p_name => 'title', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_header_col_idx));

            apex_json.write(p_name => 'content', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_content_col_idx));

            apex_json.write(p_name => 'image', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_image_col_idx));

            IF c_default_pos_src = 'COLUMNS' THEN
                IF l_region_column_idx IS NOT NULL THEN
                    apex_json.write(p_name => 'col', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_column_idx),
                    1));
                ELSE
                    apex_json.write(p_name => 'col', p_value => 1);
                END IF;

                IF l_region_row_idx IS NOT NULL THEN
                    apex_json.write(p_name => 'row', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_row_idx), 1));

                ELSE
                    apex_json.write(p_name => 'row', p_value => 1);
                END IF;

                IF l_region_xsize_idx IS NOT NULL THEN
                    apex_json.write(p_name => 'size_x', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_xsize_idx), 1));
                ELSE
                    apex_json.write(p_name => 'size_x', p_value => 1);
                END IF;

                IF l_region_ysize_idx IS NOT NULL THEN
                    apex_json.write(p_name => 'size_y', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx =>  l_region_ysize_idx), 1));
                ELSE
                    apex_json.write(p_name => 'size_y', p_value => 1);
                END IF;

            END IF;

            apex_json.close_object;
        END LOOP;

        apex_exec.close(l_context);
        apex_json.close_all;
        RETURN l_return;
    END load_plugin;

FUNCTION save_colection (
        p_region  IN  apex_plugin.t_region,
        p_plugin  IN  apex_plugin.t_plugin
    ) 
  return apex_plugin.t_region_ajax_result
    as
      l_return apex_plugin.t_region_ajax_result;
      json_clob clob;
      l_token varchar2(32000);
      
      l_values APEX_JSON.t_values; 
      l_count number;
      l_apex_collection_name varchar2(255) := p_region.attribute_18;
    begin
    
	 dbms_lob.createtemporary(json_clob, false, dbms_lob.session);
	 for i in 1 .. apex_application.g_f01.count loop
          l_token := wwv_flow.g_f01(i);
          if length(l_token) > 0 then
               dbms_lob.append(
                    dest_lob => json_clob,
                    src_lob => l_token
               );
          end if;
	 end loop;
     
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(
        p_collection_name => l_apex_collection_name);
        
     apex_json.parse(p_values=>l_values, p_source=>json_clob);
     l_count:=apex_json.get_count(p_path=>'.',p_values => l_values);
        FOR i in 1 .. l_count LOOP
        
        APEX_COLLECTION.ADD_MEMBER(
            p_collection_name => l_apex_collection_name,
            p_n001            => apex_json.get_number ( p_path=> '[%d].id', p0 => i , p_values => l_values ),     --"id"
            p_n002            => apex_json.get_number ( p_path=> '[%d].row', p0 => i , p_values => l_values ),     --"row"
            p_n003            => apex_json.get_number ( p_path=> '[%d].col', p0 => i , p_values => l_values ),     --"col"
            p_n004            => apex_json.get_number ( p_path=> '[%d].size_x', p0 => i , p_values => l_values ),     -- "size_x":
            p_n005            => apex_json.get_number ( p_path=> '[%d].size_y', p0 => i , p_values => l_values )      --"size_y"
        );
          
        END LOOP;
        
      return l_return;
      
 END save_colection;
 
FUNCTION ajax_plugin (
        p_region  IN  apex_plugin.t_region,
        p_plugin  IN  apex_plugin.t_plugin
    ) 
  return apex_plugin.t_region_ajax_result
    as
      l_return apex_plugin.t_region_ajax_result;
    begin
    
      case upper(apex_application.g_x01)
        when 'LOAD' then 
            l_return := load_plugin( p_region => p_region, p_plugin => p_plugin );
        when 'SAVE' then
            l_return := save_colection( p_region => p_region, p_plugin => p_plugin );
        else null;
      end case;
    
      return l_return;
 END ajax_plugin;