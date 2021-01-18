prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>1480597825072457
,p_default_application_id=>101
,p_default_owner=>'APEX_GRIDSTER_PLUGIN'
);
end;
/
prompt --application/shared_components/plugins/region_type/pl_yah0000_gridster_plugin
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(1619300593093577)
,p_plugin_type=>'REGION TYPE'
,p_name=>'PL.YAH0000.GRIDSTER_PLUGIN'
,p_display_name=>'Gridster Plugin'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#jquery.dsmorse-gridster.min.js',
'#PLUGIN_FILES#gridster_plugin.js',
''))
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#jquery.dsmorse-gridster.min.css',
'#PLUGIN_FILES#gridster_plugin.css',
''))
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_plugin (',
'        p_region               IN  apex_plugin.t_region,',
'        p_plugin               IN  apex_plugin.t_plugin,',
'        p_is_printer_friendly  IN  BOOLEAN',
'    ) RETURN apex_plugin.t_region_render_result IS',
'',
'        l_ajax_identifier        VARCHAR2(255) := apex_plugin.get_ajax_identifier;',
'        v_no_data_found_message  VARCHAR2(255) := p_region.no_data_found_message;',
'        vr_result                apex_plugin.t_region_render_result;',
'        c_region_static_id       CONSTANT VARCHAR2(300) := p_region.static_id;',
'    ',
'',
'        c_height                 CONSTANT VARCHAR2(10) := nvl(p_region.attribute_11,''500px'');',
'        c_save_button            CONSTANT VARCHAR(200) := apex_escape.html(nvl(p_region.attribute_15, ''Save layout''));',
'        c_position_store_mode    CONSTANT VARCHAR(200) := p_region.attribute_16;',
'        c_allow_to_relocate      CONSTANT VARCHAR(200) := p_region.attribute_14;',
'        c_default_color          CONSTANT VARCHAR(200) := p_region.attribute_12;',
'        c_item_pos_src           CONSTANT VARCHAR(200) := p_region.attribute_17;',
'        c_default_pos_src        CONSTANT VARCHAR(200) := p_region.attribute_05;',
'        c_default_font_color     CONSTANT VARCHAR(200) := p_region.attribute_13;',
'    BEGIN',
'        htp.style(''',
'      .gridster .container {',
'        background-color: ''',
'                  || c_default_color',
'                  || ''; ',
'        color: ''',
'                  || c_default_font_color',
'                  || '';',
'    }'');',
'',
'        htp.p(''<div class="gridster">'');',
'        IF (',
'            c_allow_to_relocate = ''Y''',
'            AND c_position_store_mode IS NOT NULL',
'        ) THEN',
'            htp.p(''<div class="buttons"><button type="button" class="t-Button t-Button--icon t-Button--hot t-Button--iconLeft"><span aria-hidden="true" class="t-Icon t-Icon--left fa fa-save"></span>''',
'                  || c_save_button',
'                  || ''</button></div>'');',
'        END IF;',
'',
'        htp.p(''<ul>                  ',
'            </ul>         ',
'            </div>'');',
'        apex_javascript.add_onload_code('' onLoadFn("''',
'                                        || l_ajax_identifier',
'                                        || ''", "''',
'                                        || c_region_static_id',
'                                        || ''" ,"''',
'                                        || c_allow_to_relocate',
'                                        || ''","''',
'                                        || c_position_store_mode',
'                                        || ''","''',
'                                        || c_item_pos_src',
'                                        || ''", "''',
'                                        || c_default_pos_src',
'                                        || ''");'');',
'',
'        RETURN vr_result;',
'    END;',
'',
'    FUNCTION load_plugin (',
'        p_region  IN  apex_plugin.t_region,',
'        p_plugin  IN  apex_plugin.t_plugin',
'    ) RETURN apex_plugin.t_region_ajax_result IS',
'',
'        l_return               apex_plugin.t_region_ajax_result;',
'        l_rows_count           NUMBER;      ',
'        c_position_store_mode  CONSTANT VARCHAR(200) := p_region.attribute_16;',
'        c_allow_to_relocate    CONSTANT VARCHAR(200) := p_region.attribute_14;',
'        c_item_pos_src         CONSTANT VARCHAR(200) := p_region.attribute_17;',
'        c_default_pos_src      CONSTANT VARCHAR(200) := p_region.attribute_05;',
'        c_default_pos_json     CONSTANT CLOB := p_region.attribute_10;',
'        l_context              apex_exec.t_context;',
'        l_columns              apex_exec.t_columns;',
'        l_idx                  PLS_INTEGER := 0;',
'        l_id_col_idx           PLS_INTEGER;',
'        l_header_col_idx       PLS_INTEGER;',
'        l_content_col_idx      PLS_INTEGER;',
'        l_image_col_idx        PLS_INTEGER;',
'        l_region_column_idx    PLS_INTEGER;',
'        l_region_row_idx       PLS_INTEGER;',
'        l_region_xsize_idx     PLS_INTEGER;',
'        l_region_ysize_idx     PLS_INTEGER;',
'        l_values               apex_json.t_values;',
'        l_row_found            BOOLEAN;',
'    BEGIN',
'    ',
'        l_context := apex_exec.open_query_context(p_columns => l_columns);',
'        l_id_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_01);',
'',
'        l_header_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_02);',
'',
'        l_content_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_03);',
'',
'        l_image_col_idx := apex_exec.get_column_position(p_context => l_context, p_column_name => p_region.attribute_04);',
'',
'        CASE c_default_pos_src',
'            WHEN ''COLUMNS'' THEN',
'                IF p_region.attribute_06 IS NOT NULL THEN',
'                    l_region_column_idx := apex_exec.get_column_position(p_context => l_context,',
'                                                                    p_column_name => p_region.attribute_06);',
'                END IF;',
'',
'                IF p_region.attribute_07 IS NOT NULL THEN',
'                    l_region_row_idx := apex_exec.get_column_position(p_context => l_context,',
'                                                                    p_column_name => p_region.attribute_07);',
'',
'                END IF;',
'',
'                IF p_region.attribute_08 IS NOT NULL THEN',
'                    l_region_xsize_idx := apex_exec.get_column_position(p_context => l_context,',
'                                                                    p_column_name => p_region.attribute_08);',
'                END IF;',
'',
'                IF p_region.attribute_09 IS NOT NULL THEN',
'                    l_region_ysize_idx := apex_exec.get_column_position(p_context => l_context,',
'                                                                    p_column_name => p_region.attribute_09);',
'                END IF;',
'',
'            ELSE',
'                NULL;',
'        END CASE;',
'',
'        l_rows_count := apex_exec.get_total_row_count(l_context);',
'        apex_json.open_object;',
'        apex_json.write(p_name => ''success'', p_value => true);',
'        IF c_default_pos_src = ''JSON'' THEN',
'            apex_json.parse(p_values => l_values, p_source => c_default_pos_json);',
'            apex_json.write(''grid_locations'', l_values);',
'        END IF;',
'',
'        apex_json.open_array(p_name => ''grid_data'');',
'        WHILE apex_exec.next_row(p_context => l_context) LOOP',
'            apex_json.open_object;',
'            apex_json.write(p_name => ''id'', p_value => apex_exec.get_number(p_context => l_context, p_column_idx => l_id_col_idx));',
'',
'            apex_json.write(p_name => ''title'', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_header_col_idx));',
'',
'            apex_json.write(p_name => ''content'', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_content_col_idx));',
'',
'            apex_json.write(p_name => ''image'', p_value => apex_exec.get_varchar2(p_context => l_context, p_column_idx => l_image_col_idx));',
'',
'            IF c_default_pos_src = ''COLUMNS'' THEN',
'                IF l_region_column_idx IS NOT NULL THEN',
'                    apex_json.write(p_name => ''col'', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_column_idx),',
'                    1));',
'                ELSE',
'                    apex_json.write(p_name => ''col'', p_value => 1);',
'                END IF;',
'',
'                IF l_region_row_idx IS NOT NULL THEN',
'                    apex_json.write(p_name => ''row'', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_row_idx), 1));',
'',
'                ELSE',
'                    apex_json.write(p_name => ''row'', p_value => 1);',
'                END IF;',
'',
'                IF l_region_xsize_idx IS NOT NULL THEN',
'                    apex_json.write(p_name => ''size_x'', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx => l_region_xsize_idx), 1));',
'                ELSE',
'                    apex_json.write(p_name => ''size_x'', p_value => 1);',
'                END IF;',
'',
'                IF l_region_ysize_idx IS NOT NULL THEN',
'                    apex_json.write(p_name => ''size_y'', p_value => nvl(apex_exec.get_number(p_context => l_context, p_column_idx =>  l_region_ysize_idx), 1));',
'                ELSE',
'                    apex_json.write(p_name => ''size_y'', p_value => 1);',
'                END IF;',
'',
'            END IF;',
'',
'            apex_json.close_object;',
'        END LOOP;',
'',
'        apex_exec.close(l_context);',
'        apex_json.close_all;',
'        RETURN l_return;',
'    END load_plugin;',
'',
'FUNCTION save_colection (',
'        p_region  IN  apex_plugin.t_region,',
'        p_plugin  IN  apex_plugin.t_plugin',
'    ) ',
'  return apex_plugin.t_region_ajax_result',
'    as',
'      l_return apex_plugin.t_region_ajax_result;',
'      json_clob clob;',
'      l_token varchar2(32000);',
'      ',
'      l_values APEX_JSON.t_values; ',
'      l_count number;',
'      l_apex_collection_name varchar2(255) := p_region.attribute_18;',
'    begin',
'    ',
'	 dbms_lob.createtemporary(json_clob, false, dbms_lob.session);',
'	 for i in 1 .. apex_application.g_f01.count loop',
'          l_token := wwv_flow.g_f01(i);',
'          if length(l_token) > 0 then',
'               dbms_lob.append(',
'                    dest_lob => json_clob,',
'                    src_lob => l_token',
'               );',
'          end if;',
'	 end loop;',
'     ',
'    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(',
'        p_collection_name => l_apex_collection_name);',
'        ',
'     apex_json.parse(p_values=>l_values, p_source=>json_clob);',
'     l_count:=apex_json.get_count(p_path=>''.'',p_values => l_values);',
'        FOR i in 1 .. l_count LOOP',
'        ',
'        APEX_COLLECTION.ADD_MEMBER(',
'            p_collection_name => l_apex_collection_name,',
'            p_n001            => apex_json.get_number ( p_path=> ''[%d].id'', p0 => i , p_values => l_values ),     --"id"',
'            p_n002            => apex_json.get_number ( p_path=> ''[%d].row'', p0 => i , p_values => l_values ),     --"row"',
'            p_n003            => apex_json.get_number ( p_path=> ''[%d].col'', p0 => i , p_values => l_values ),     --"col"',
'            p_n004            => apex_json.get_number ( p_path=> ''[%d].size_x'', p0 => i , p_values => l_values ),     -- "size_x":',
'            p_n005            => apex_json.get_number ( p_path=> ''[%d].size_y'', p0 => i , p_values => l_values )      --"size_y"',
'        );',
'          ',
'        END LOOP;',
'        ',
'      return l_return;',
'      ',
' END save_colection;',
' ',
'FUNCTION ajax_plugin (',
'        p_region  IN  apex_plugin.t_region,',
'        p_plugin  IN  apex_plugin.t_plugin',
'    ) ',
'  return apex_plugin.t_region_ajax_result',
'    as',
'      l_return apex_plugin.t_region_ajax_result;',
'    begin',
'    ',
'      case upper(apex_application.g_x01)',
'        when ''LOAD'' then ',
'            l_return := load_plugin( p_region => p_region, p_plugin => p_plugin );',
'        when ''SAVE'' then',
'            l_return := save_colection( p_region => p_region, p_plugin => p_plugin );',
'        else null;',
'      end case;',
'    ',
'      return l_return;',
' END ajax_plugin;'))
,p_api_version=>2
,p_render_function=>'RENDER_PLUGIN'
,p_ajax_function=>'AJAX_PLUGIN'
,p_standard_attributes=>'SOURCE_LOCATION:NO_DATA_FOUND_MESSAGE:VALUE_ESCAPE_OUTPUT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'The plug-in enables dynamic drawing of regions based on a SQL query. Users can adjust regions according to their needs and save them in various ways.',
'See more at project webpage: https://github.com/Yah0000/apex_gridster_plugin'))
,p_version_identifier=>'1.1'
,p_about_url=>'https://github.com/Yah0000/apex_gridster_plugin'
,p_plugin_comment=>'The plug-in enables dynamic drawing of regions based on a SQL query. Users can adjust regions according to their needs and save them in various ways.'
,p_files_version=>7
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1620810043115135)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Region identifier'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'VARCHAR2:NUMBER:ROWID'
,p_is_translatable=>false
,p_help_text=>'Query column with item ID. Connects saved size and position of elements with data from SQL.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1621102732117920)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Region header'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_default_value=>'Query column with headers of regions'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1621426156121517)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Region content'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_default_value=>'Query column with contents of regions (allows the use HTML)'
,p_column_data_types=>'VARCHAR2:CLOB'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1621780248125867)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Region image'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_show_in_wizard=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Query column with APEX icon class.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1622024124133331)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Default position based on'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'COLUMNS'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Source of regions defaults positions and sizes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1622390508134752)
,p_plugin_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_display_sequence=>10
,p_display_value=>'Columns'
,p_return_value=>'COLUMNS'
,p_help_text=>'Allows to retrieve the default positions based on the query columns'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1622787627135692)
,p_plugin_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_display_sequence=>20
,p_display_value=>'JSON'
,p_return_value=>'JSON'
,p_help_text=>'Allows to retrieve the default positions based on the JSON format'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1623461926154614)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Region column (X position)'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMNS'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1623761401160615)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Region row (Y position)'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMNS'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1624028282170555)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Region X-size'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMNS'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1624375499173730)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Region Y-size'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMNS'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1624685505177348)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'JSON with positions'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1622024124133331)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'JSON'
,p_examples=>'[{"id":5,"row":1,"col":1,"size_x":2,"size_y":1},{"id":3,"row":1,"col":3,"size_x":2,"size_y":1},{"id":1,"row":1,"col":5,"size_x":2,"size_y":2},{"id":2,"row":2,"col":1,"size_x":2,"size_y":1},{"id":4,"row":2,"col":3,"size_x":2,"size_y":1}]'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Default positions source in JSON. ',
'JSON format:',
'[',
'	{',
'		"id": 5,',
'		"row": 1,',
'		"col": 1,',
'		"size_x": 2,',
'		"size_y": 1',
'	},',
'	{...}',
']'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1624958920180742)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Height'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'500px'
,p_display_length=>200
,p_max_length=>10
,p_is_translatable=>false
,p_text_case=>'LOWER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1625222838183551)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Regions headers color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#FFFFFF'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1625529419185270)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Font default color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#000000'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1625812975192431)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Allow user to change positions'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Disabling and enabling the modification and size of regions by end users.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1626155262196713)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_prompt=>'Save layout button text'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'Save layout'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(1625812975192431)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1626411251201736)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_prompt=>'Store user position and size in'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1625812975192431)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_null_text=>'Don''t store'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Choose where items saved by end users are saved.',
'<ul>',
'<li><strong>Don''t store</strong> - Position always get from region defaults positions, but users can still change its.</li>',
'<li><strong>Local storage</strong> - Saves positions in the end user browser.</li>',
'<li><strong>APEX Item</strong> - JSON with items will be stored in APEX item</li>',
'<li><strong>APEX Collcetion</strong> - JSON with items will be stored in APEX Collection</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1626775965203317)
,p_plugin_attribute_id=>wwv_flow_api.id(1626411251201736)
,p_display_sequence=>10
,p_display_value=>'Local storage'
,p_return_value=>'LOCAL_STORAGE'
,p_help_text=>'Saves positions in the end user browser (it also support for public users without an application user).'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1627158146204171)
,p_plugin_attribute_id=>wwv_flow_api.id(1626411251201736)
,p_display_sequence=>20
,p_display_value=>'APEX Item'
,p_return_value=>'APEX_ITEM'
,p_help_text=>'JSON with items will be stored in APEX item'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1711496791422955)
,p_plugin_attribute_id=>wwv_flow_api.id(1626411251201736)
,p_display_sequence=>30
,p_display_value=>'APEX Colection'
,p_return_value=>'APEX_COLLECTION'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1627582608209190)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_prompt=>'Item to store positions'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1626411251201736)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'APEX_ITEM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1710694140417165)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_prompt=>'Colection name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'GRIDSTER_POSITION'
,p_max_length=>255
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(1626411251201736)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'APEX_COLLECTION'
,p_text_case=>'UPPER'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'The name of the APEX collection in which the items will be saved.',
'',
'The columns assigned:',
'<ul>',
'<li>n001 => "id" </li>',
'<li>n002 => "row" </li>',
'<li>n003 => "col" </li>',
'<li>n004 => "size_x" </li>',
'<li>n005 => "size_y"</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(1619981983097120)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_name=>'SOURCE_LOCATION'
,p_depending_on_has_to_exist=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'	ROWNUM ID, ',
'	COLUMN_VALUE HEADER, ',
'	COLUMN_VALUE || '' <br>''||to_char(CURRENT_TIMESTAMP, ''HH24:MI:SS'') CONTENT  , ',
'CASE',
'     WHEN ROWNUM >2 ',
'    THEN   ''fa-sun-o''',
'    else NULL',
'END ICON',
'from table (apex_string.split(''APEX<br>APEX;ORACLE;APEX PLUGIN;SAMPLE DATA;SAMPLE MORE DATA'', '';'' ))'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    ROWNUM ID,',
'    HEADER, ',
'    CONTENT,',
'    ICON ',
'from TABLE;'))
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(1620422856102694)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_name=>'savelayout'
,p_display_name=>'SaveLayout'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6772696473746572207B0A096865696768743A20313030253B0A20207D0A0A20202E6772696473746572202E627574746F6E73207B0A09666C6F61743A2072696768743B0A20207D0A0A20202E6772696473746572202E627574746F6E732062757474';
wwv_flow_api.g_varchar2_table(2) := '6F6E207B0A097A2D696E6465783A203939393B0A20207D0A0A2E677269647374657220756C207B0A0A096D617267696E2D6C6566743A203070783B0A096D617267696E2D72696768743A203070780A20207D0A0A20202E6772696473746572202E67732D';
wwv_flow_api.g_varchar2_table(3) := '77207B0A096C6973742D7374796C653A206E6F6E653B0A20207D0A0A0A200A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1628741648295799)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_file_name=>'gridster_plugin.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722067726964737465723B0A0A66756E6374696F6E206472617747726964737465722864617461496E2C206772696473746572496E29207B0A097661722073657269616C697A6174696F6E203D2047726964737465722E736F72745F62795F726F77';
wwv_flow_api.g_varchar2_table(2) := '5F616E645F636F6C5F6173632864617461496E293B0A096772696473746572496E2E72656D6F76655F616C6C5F7769646765747328293B0A0A0973657269616C697A6174696F6E2E666F72456163682866756E6374696F6E2028656E74727929207B0A0A';
wwv_flow_api.g_varchar2_table(3) := '09096772696473746572496E2E6164645F77696467657428273C6C6920636C6173733D22742D526567696F6E20742D526567696F6E2D2D73686F7749636F6E20742D526567696F6E2D2D7363726F6C6C426F647920222069643D2227202B20656E747279';
wwv_flow_api.g_varchar2_table(4) := '2E6964202B2027223E270A0909092B2027203C64697620636C6173733D22742D526567696F6E2D68656164657220636F6E7461696E6572223E270A0909092B202720203C64697620636C6173733D22742D526567696F6E2D6865616465724974656D7320';
wwv_flow_api.g_varchar2_table(5) := '742D526567696F6E2D6865616465724974656D732D2D7469746C65223E270A0909092B2028656E7472792E696D61676520213D3D20756E646566696E6564203F2027202020203C7370616E20636C6173733D22742D526567696F6E2D6865616465724963';
wwv_flow_api.g_varchar2_table(6) := '6F6E223E3C7370616E20636C6173733D22742D49636F6E2066612027202B20656E7472792E696D616765202B20272220617269612D68696464656E3D2274727565223E3C2F7370616E3E3C2F7370616E3E27203A202222290A0909092B2027202020203C';
wwv_flow_api.g_varchar2_table(7) := '683220636C6173733D22742D526567696F6E2D7469746C65223E27202B20656E7472792E7469746C65202B20273C2F68323E270A0909092B202720203C2F6469763E270A0909092B202720203C64697620636C6173733D22742D526567696F6E2D686561';
wwv_flow_api.g_varchar2_table(8) := '6465724974656D7320742D526567696F6E2D6865616465724974656D732D2D627574746F6E73223E3C7370616E20636C6173733D226A732D6D6178696D697A65427574746F6E436F6E7461696E6572223E3C2F7370616E3E3C2F6469763E270A0909092B';
wwv_flow_api.g_varchar2_table(9) := '2027203C2F6469763E270A0909092B2027203C64697620636C6173733D22742D526567696F6E2D626F647957726170223E270A0909092B20272020203C64697620636C6173733D22742D526567696F6E2D627574746F6E7320742D526567696F6E2D6275';
wwv_flow_api.g_varchar2_table(10) := '74746F6E732D2D746F70223E270A0909092B2027202020203C64697620636C6173733D22742D526567696F6E2D627574746F6E732D6C656674223E3C2F6469763E270A0909092B2027202020203C64697620636C6173733D22742D526567696F6E2D6275';
wwv_flow_api.g_varchar2_table(11) := '74746F6E732D7269676874223E3C2F6469763E270A0909092B20272020203C2F6469763E270A0909092B20272020203C64697620636C6173733D22742D526567696F6E2D626F6479223E270A0909092B2027202020202027202B20656E7472792E636F6E';
wwv_flow_api.g_varchar2_table(12) := '74656E74202B20272020202020270A0909092B20272020203C2F6469763E270A0909092B20272020203C64697620636C6173733D22742D526567696F6E2D627574746F6E7320742D526567696F6E2D627574746F6E732D2D626F74746F6D223E270A0909';
wwv_flow_api.g_varchar2_table(13) := '092B2027202020203C64697620636C6173733D22742D526567696F6E2D627574746F6E732D6C656674223E3C2F6469763E270A0909092B2027202020203C64697620636C6173733D22742D526567696F6E2D627574746F6E732D7269676874223E3C2F64';
wwv_flow_api.g_varchar2_table(14) := '69763E270A0909092B20272020203C2F6469763E270A0909092B2027203C2F6469763E270A0909092B20273C2F6C693E270A0909092C20656E7472792E73697A655F782C20656E7472792E73697A655F792C20656E7472792E636F6C2C20656E7472792E';
wwv_flow_api.g_varchar2_table(15) := '726F77293B0A097D293B0A0A7D0A0A66756E6374696F6E20736176654C6F63616C53746F726167652876616C75655F746F5F7361766529207B0A0A09766172206C6F63616C53746F72616765203D20617065782E73746F726167652E67657453636F7065';
wwv_flow_api.g_varchar2_table(16) := '644C6F63616C53746F72616765287B0A09097072656669783A2022504C5547494E5F53455454494E4753222C0A090975736541707049643A20747275650A097D293B0A0A096C6F63616C53746F726167652E7365744974656D28225265706F72745F446C';
wwv_flow_api.g_varchar2_table(17) := '697374222C2076616C75655F746F5F73617665293B0A7D0A0A66756E6374696F6E20726561644C6F63616C53746F726167652829207B0A09766172206C6F63616C53746F72616765203D20617065782E73746F726167652E67657453636F7065644C6F63';
wwv_flow_api.g_varchar2_table(18) := '616C53746F72616765287B0A09097072656669783A2022504C5547494E5F53455454494E4753222C0A090975736541707049643A20747275650A097D293B0A0972657475726E206C6F63616C53746F726167652E6765744974656D28225265706F72745F';
wwv_flow_api.g_varchar2_table(19) := '446C69737422293B0A7D0A2F2F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A202A2F0A76617220616A61785F6964656E7469666965722C20726567696F6E';
wwv_flow_api.g_varchar2_table(20) := '5F7374617469635F69643B0A7661722073617665427574746F6E203D20646F63756D656E742E717565727953656C6563746F7228222E6772696473746572203E202E627574746F6E73203E20627574746F6E22293B0A0A0A66756E6374696F6E206F6E4C';
wwv_flow_api.g_varchar2_table(21) := '6F6164466E286C5F616A61785F6964656E7469666965722C20726567696F6E5F7374617469635F69642C206C5F616C6C6F775F746F5F72656C6F636174652C206C5F706F736974696F6E5F73746F72655F6D6F64652C206C5F6974656D5F706F735F7372';
wwv_flow_api.g_varchar2_table(22) := '632C206C5F64656661756C745F706F735F73726329207B0A0A09616A61785F6964656E746966696572203D206C5F616A61785F6964656E7469666965723B0A096772696473746572203D202428222322202B20726567696F6E5F7374617469635F696420';
wwv_flow_api.g_varchar2_table(23) := '2B2022202E677269647374657220756C22292E6772696473746572287B0A09097769646765745F626173655F64696D656E73696F6E733A205B3132352C203132355D2C0A09097769646765745F6D617267696E733A205B352C20355D2C0A09096175746F';
wwv_flow_api.g_varchar2_table(24) := '67726F775F636F6C733A20747275652C0A0909726573697A653A207B0A090909656E61626C65643A20286C5F616C6C6F775F746F5F72656C6F63617465203D3D2027592729203F2074727565203A2066616C73650A09097D2C0A0909647261676761626C';
wwv_flow_api.g_varchar2_table(25) := '653A207B0A09090973746F703A2066756E6374696F6E20286576656E742C20756929207B0A0909097D0A09097D2C0A090973657269616C697A655F706172616D733A2066756E6374696F6E202824772C2077676429207B0A09090972657475726E207B0A';
wwv_flow_api.g_varchar2_table(26) := '0909090969643A2024772E617474722827696427292C0A09090909636F6C3A207767642E636F6C2C0A09090909726F773A207767642E726F772C0A0909090973697A655F783A207767642E73697A655F782C0A0909090973697A655F793A207767642E73';
wwv_flow_api.g_varchar2_table(27) := '697A655F792C0A0909090968746D6C3A2024772E66696E642827696427292E76616C28290A0909097D3B0A09097D2C0A097D292E646174612822677269647374657222293B0A0A0967726964737465722E706F736974696F6E5F73746F72655F6D6F6465';
wwv_flow_api.g_varchar2_table(28) := '203D206C5F706F736974696F6E5F73746F72655F6D6F64653B0A0967726964737465722E6974656D5F706F735F737263203D206C5F6974656D5F706F735F7372633B0A0967726964737465722E64656661756C745F706F736974696F6E5F737263203D20';
wwv_flow_api.g_varchar2_table(29) := '6C5F64656661756C745F706F735F7372633B0A0A09696620286C5F616C6C6F775F746F5F72656C6F6361746520213D2027592729207B0A090967726964737465722E64697361626C6528293B0A097D0A0A0952656C6F6164477269647374657228677269';
wwv_flow_api.g_varchar2_table(30) := '64737465722C206C5F616A61785F6964656E7469666965722C2027494E495427293B0A0A09617065782E726567696F6E2E63726561746528726567696F6E5F7374617469635F69642C207B0A0909747970653A2022726567696F6E222C0A090972656672';
wwv_flow_api.g_varchar2_table(31) := '6573683A2066756E6374696F6E202829207B0A09090952656C6F616447726964737465722867726964737465722C206C5F616A61785F6964656E7469666965722C20275245465245534827293B0A09097D0A097D293B0A0A096966202873617665427574';
wwv_flow_api.g_varchar2_table(32) := '746F6E20213D3D20756E646566696E65642026262073617665427574746F6E20213D3D206E756C6C29207B0A090973617665427574746F6E2E6F6E636C69636B203D2066756E6374696F6E202829207B0A09090953617665506F736974696F6E7328293B';
wwv_flow_api.g_varchar2_table(33) := '0A090909617065782E6D6573736167652E73686F77506167655375636365737328224368616E6765732073617665642122293B0A090909617065782E6576656E742E7472696767657228646F63756D656E742C2027736176656C61796F757427293B0A0A';
wwv_flow_api.g_varchar2_table(34) := '090909617065782E6A517565727928222322202B20726567696F6E5F7374617469635F6964292E747269676765722822736176656C61796F7574222C207B7D293B0A09097D3B0A097D0A7D0A0A66756E6374696F6E2052656C6F61644772696473746572';
wwv_flow_api.g_varchar2_table(35) := '286772696473746572496E2C206C5F616A61785F6964656E7469666965722C206D6F646529207B0A09636F6E736F6C652E6C6F67286D6F6465293B0A09766172206C6F636174696F6E5F6265666F72655F72656665727368203D20476574506F73697469';
wwv_flow_api.g_varchar2_table(36) := '6F6E7328293B0A0A09617065782E7365727665722E706C7567696E286C5F616A61785F6964656E7469666965722C207B0A09097830313A20224C4F4144220A097D2C207B0A090964617461547970653A202274657874222C0A0909737563636573733A20';
wwv_flow_api.g_varchar2_table(37) := '66756E6374696F6E20286461746129207B0A0909097661722067726964737465725F64617461203D204A534F4E2E70617273652864617461293B0A09090976617220677269645F64617461203D2067726964737465725F646174612E677269645F646174';
wwv_flow_api.g_varchar2_table(38) := '613B0A090909766172206C61796F75745F646174612C206C61796F75745F646174615F4A534F4E3B0A0A0909096966202867726964737465722E64656661756C745F706F736974696F6E5F737263203D3D3D20274A534F4E2729207B0A0A090909096C65';
wwv_flow_api.g_varchar2_table(39) := '74206F70203D20677269645F646174612E6D61702828652C206929203D3E207B0A09090909096C65742074656D70203D2067726964737465725F646174612E677269645F6C6F636174696F6E732E66696E6428656C656D656E74203D3E20656C656D656E';
wwv_flow_api.g_varchar2_table(40) := '742E6964203D3D3D20652E6964290A09090909096966202874656D7020213D3D20756E646566696E656429207B0A090909090909652E73697A655F78203D202874656D702E73697A655F78203D3D3D20756E646566696E656429203F20652E73697A655F';
wwv_flow_api.g_varchar2_table(41) := '78203A2074656D702E73697A655F783B0A090909090909652E73697A655F79203D202874656D702E73697A655F79203D3D3D20756E646566696E656429203F20652E73697A655F79203A2074656D702E73697A655F793B0A090909090909652E636F6C20';
wwv_flow_api.g_varchar2_table(42) := '3D202874656D702E636F6C203D3D3D20756E646566696E656429203F20652E636F6C203A2074656D702E636F6C3B0A090909090909652E726F77203D202874656D702E726F77203D3D3D20756E646566696E656429203F20652E726F77203A2074656D70';
wwv_flow_api.g_varchar2_table(43) := '2E726F773B0A09090909097D20656C7365207B0A090909090909652E73697A655F78203D20313B0A090909090909652E73697A655F79203D20313B0A090909090909652E636F6C203D20313B0A090909090909652E726F77203D20313B0A09090909097D';
wwv_flow_api.g_varchar2_table(44) := '0A090909090972657475726E20653B0A090909097D290A0909097D0A0A090909696620286D6F6465203D3D3D2027524546524553482729207B0A090909096C61796F75745F64617461203D206C6F636174696F6E5F6265666F72655F726566657273683B';
wwv_flow_api.g_varchar2_table(45) := '0A0909097D0A0A090909696620286D6F6465203D3D3D2027494E49542729207B0A0909090973776974636820286772696473746572496E2E706F736974696F6E5F73746F72655F6D6F646529207B0A09090909096361736520274C4F43414C5F53544F52';
wwv_flow_api.g_varchar2_table(46) := '414745273A0A0909090909096C61796F75745F646174615F4A534F4E203D20726561644C6F63616C53746F7261676528293B0A090909090909627265616B3B0A0909090909636173652027415045585F4954454D273A0A0909090909096C61796F75745F';
wwv_flow_api.g_varchar2_table(47) := '646174615F4A534F4E203D20617065782E6974656D2867726964737465722E6974656D5F706F735F737263292E67657456616C756528293B0A090909090909627265616B3B0A0909090909636173652027415045585F434F4C4C454354494F4E273A0A09';
wwv_flow_api.g_varchar2_table(48) := '0909090909627265616B3B0A090909097D0A0A0A09090909747279207B0A09090909096C61796F75745F64617461203D204A534F4E2E7061727365286C61796F75745F646174615F4A534F4E293B0A090909097D20636174636820286529207B0A090909';
wwv_flow_api.g_varchar2_table(49) := '09096C61796F75745F64617461203D206E756C6C3B0A090909097D0A0909097D0A090909696620286C61796F75745F64617461202626206C61796F75745F6461746120213D3D20756E646566696E656429207B0A0A090909096C6574206F70203D206772';
wwv_flow_api.g_varchar2_table(50) := '69645F646174612E6D61702828652C206929203D3E207B0A09090909096C65742074656D70203D206C61796F75745F646174612E66696E6428656C656D656E74203D3E20656C656D656E742E6964203D3D3D20652E6964290A0909090909696620287465';
wwv_flow_api.g_varchar2_table(51) := '6D7020213D3D20756E646566696E656429207B0A090909090909652E73697A655F78203D202874656D702E73697A655F78203D3D3D20756E646566696E656429203F20652E73697A655F78203A2074656D702E73697A655F783B0A090909090909652E73';
wwv_flow_api.g_varchar2_table(52) := '697A655F79203D202874656D702E73697A655F79203D3D3D20756E646566696E656429203F20652E73697A655F79203A2074656D702E73697A655F793B0A090909090909652E636F6C203D202874656D702E636F6C203D3D3D20756E646566696E656429';
wwv_flow_api.g_varchar2_table(53) := '203F20652E636F6C203A2074656D702E636F6C3B0A090909090909652E726F77203D202874656D702E726F77203D3D3D20756E646566696E656429203F20652E726F77203A2074656D702E726F773B0A09090909097D0A090909090972657475726E2065';
wwv_flow_api.g_varchar2_table(54) := '3B0A090909097D290A0A0909097D0A0909096472617747726964737465722867726964737465725F646174612E677269645F646174612C206772696473746572496E293B0A09097D0A097D293B0A0A7D0A0A66756E6374696F6E20536176654C6F636174';
wwv_flow_api.g_varchar2_table(55) := '696F6E546F436F6C6C656374696F6E284A534F4E696E29207B0A0A09766172206C5F616A61785F6964656E746966696572203D20616A61785F6964656E7469666965723B0A0A09617065782E7365727665722E706C7567696E286C5F616A61785F696465';
wwv_flow_api.g_varchar2_table(56) := '6E7469666965722C0A09097B207830313A202253415645222C206630313A20617065782E7365727665722E6368756E6B284A534F4E696E29207D2C207B0A090964617461547970653A202274657874222C0A0909737563636573733A2066756E6374696F';
wwv_flow_api.g_varchar2_table(57) := '6E20286461746129207B0A090909636F6E736F6C652E6C6F672864617461293B0A0A09097D0A097D293B0A0A7D0A0A66756E6374696F6E20476574506F736974696F6E732829207B0A0A097661722073657269616C697A654A736F6E417272203D206E65';
wwv_flow_api.g_varchar2_table(58) := '7720417272617928293B0A0A092428222E677269647374657220756C206C6922292E656163682866756E6374696F6E20286929207B0A09097661722073657269616C697A654A736F6E203D207B7D3B0A0909766172206964203D20242874686973292E61';
wwv_flow_api.g_varchar2_table(59) := '7474722827696427293B0A090976617220726F77203D20242874686973292E617474722827646174612D726F7727293B0A090976617220636F6C203D20242874686973292E617474722827646174612D636F6C27293B0A09097661722073697A6578203D';
wwv_flow_api.g_varchar2_table(60) := '20242874686973292E617474722827646174612D73697A657827293B0A09097661722073697A6579203D20242874686973292E617474722827646174612D73697A657927293B0A0A090973657269616C697A654A736F6E5B226964225D203D2070617273';
wwv_flow_api.g_varchar2_table(61) := '65496E74286964293B0A090973657269616C697A654A736F6E5B22726F77225D203D207061727365496E7428726F77293B0A090973657269616C697A654A736F6E5B22636F6C225D203D207061727365496E7428636F6C293B0A090973657269616C697A';
wwv_flow_api.g_varchar2_table(62) := '654A736F6E5B2273697A655F78225D203D207061727365496E742873697A6578293B0A090973657269616C697A654A736F6E5B2273697A655F79225D203D207061727365496E742873697A6579293B0A0A090973657269616C697A654A736F6E4172722E';
wwv_flow_api.g_varchar2_table(63) := '707573682873657269616C697A654A736F6E293B0A097D293B0A0A09636F6E736F6C652E6C6F672873657269616C697A654A736F6E417272293B0A0972657475726E2073657269616C697A654A736F6E4172723B0A0A7D0A0A66756E6374696F6E205361';
wwv_flow_api.g_varchar2_table(64) := '7665506F736974696F6E732829207B0A0A097661722073657269616C697A654A736F6E417272203D20476574506F736974696F6E7328293B0A0A09737769746368202867726964737465722E706F736974696F6E5F73746F72655F6D6F646529207B0A09';
wwv_flow_api.g_varchar2_table(65) := '096361736520274C4F43414C5F53544F52414745273A0A090909736176654C6F63616C53746F72616765284A534F4E2E737472696E676966792873657269616C697A654A736F6E41727229293B0A090909627265616B3B0A090963617365202741504558';
wwv_flow_api.g_varchar2_table(66) := '5F4954454D273A0A090909617065782E6974656D2867726964737465722E6974656D5F706F735F737263292E73657456616C7565284A534F4E2E737472696E676966792873657269616C697A654A736F6E41727229293B0A090909627265616B3B0A0909';
wwv_flow_api.g_varchar2_table(67) := '636173652027415045585F434F4C4C454354494F4E273A0A090909536176654C6F636174696F6E546F436F6C6C656374696F6E20284A534F4E2E737472696E676966792873657269616C697A654A736F6E4172722920293B0A090909627265616B3B0A09';
wwv_flow_api.g_varchar2_table(68) := '7D0A0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1629089378295800)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_file_name=>'gridster_plugin.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A212067726964737465722E6A73202D2076302E382E30202D20323031392D30312D3130202D202A2068747470733A2F2F64736D6F7273652E6769746875622E696F2F67726964737465722E6A732F202D20436F707972696768742028632920323031';
wwv_flow_api.g_varchar2_table(2) := '39206475636B73626F6172643B204C6963656E736564204D4954202A2F200A2E67726964737465727B706F736974696F6E3A72656C61746976657D2E67726964737465723E2A7B2D7765626B69742D7472616E736974696F6E3A686569676874202E3473';
wwv_flow_api.g_varchar2_table(3) := '2C7769647468202E34733B2D6D6F7A2D7472616E736974696F6E3A686569676874202E34732C7769647468202E34733B2D6F2D7472616E736974696F6E3A686569676874202E34732C7769647468202E34733B2D6D732D7472616E736974696F6E3A6865';
wwv_flow_api.g_varchar2_table(4) := '69676874202E34732C7769647468202E34733B7472616E736974696F6E3A686569676874202E34732C7769647468202E34737D2E6772696473746572202E67732D777B7A2D696E6465783A323B706F736974696F6E3A6162736F6C7574657D2E67726964';
wwv_flow_api.g_varchar2_table(5) := '73746572202E707265766965772D686F6C6465727B7A2D696E6465783A313B706F736974696F6E3A6162736F6C7574653B6261636B67726F756E642D636F6C6F723A236666663B626F726465722D636F6C6F723A236666663B6F7061636974793A2E337D';
wwv_flow_api.g_varchar2_table(6) := '2E6772696473746572202E706C617965722D7265766572747B7A2D696E6465783A313021696D706F7274616E743B2D7765626B69742D7472616E736974696F6E3A6C656674202E33732C746F70202E337321696D706F7274616E743B2D6D6F7A2D747261';
wwv_flow_api.g_varchar2_table(7) := '6E736974696F6E3A6C656674202E33732C746F70202E337321696D706F7274616E743B2D6F2D7472616E736974696F6E3A6C656674202E33732C746F70202E337321696D706F7274616E743B7472616E736974696F6E3A6C656674202E33732C746F7020';
wwv_flow_api.g_varchar2_table(8) := '2E337321696D706F7274616E747D2E67726964737465722E636F6C6C61707365647B6865696768743A6175746F21696D706F7274616E747D2E67726964737465722E636F6C6C6170736564202E67732D777B706F736974696F6E3A73746174696321696D';
wwv_flow_api.g_varchar2_table(9) := '706F7274616E747D2E7265616479202E67732D773A6E6F74282E707265766965772D686F6C646572292C2E7265616479202E726573697A652D707265766965772D686F6C6465727B2D7765626B69742D7472616E736974696F6E3A6F706163697479202E';
wwv_flow_api.g_varchar2_table(10) := '33732C6C656674202E33732C746F70202E33732C7769647468202E33732C686569676874202E33733B2D6D6F7A2D7472616E736974696F6E3A6F706163697479202E33732C6C656674202E33732C746F70202E33732C7769647468202E33732C68656967';
wwv_flow_api.g_varchar2_table(11) := '6874202E33733B2D6F2D7472616E736974696F6E3A6F706163697479202E33732C6C656674202E33732C746F70202E33732C7769647468202E33732C686569676874202E33733B7472616E736974696F6E3A6F706163697479202E33732C6C656674202E';
wwv_flow_api.g_varchar2_table(12) := '33732C746F70202E33732C7769647468202E33732C686569676874202E33737D2E6772696473746572202E6472616767696E672C2E6772696473746572202E726573697A696E677B7A2D696E6465783A313021696D706F7274616E743B2D7765626B6974';
wwv_flow_api.g_varchar2_table(13) := '2D7472616E736974696F6E3A616C6C20307321696D706F7274616E743B2D6D6F7A2D7472616E736974696F6E3A616C6C20307321696D706F7274616E743B2D6F2D7472616E736974696F6E3A616C6C20307321696D706F7274616E743B7472616E736974';
wwv_flow_api.g_varchar2_table(14) := '696F6E3A616C6C20307321696D706F7274616E747D2E67732D726573697A652D68616E646C657B706F736974696F6E3A6162736F6C7574653B7A2D696E6465783A317D2E67732D726573697A652D68616E646C652D626F74687B77696474683A32307078';
wwv_flow_api.g_varchar2_table(15) := '3B6865696768743A323070783B626F74746F6D3A2D3870783B72696768743A2D3870783B6261636B67726F756E642D696D6167653A75726C28646174613A696D6167652F7376672B786D6C3B6261736536342C5044393462577767646D567963326C7662';
wwv_flow_api.g_varchar2_table(16) := '6A30694D5334774969427A644746755A4746736232356C50534A756279492F50673038495330744945646C626D567959585276636A6F6751575276596D5567526D6C795A586476636D747A49454E544E6977675258687762334A3049464E575279424665';
wwv_flow_api.g_varchar2_table(17) := '48526C626E4E7062323467596E6B675157467962323467516D5668624777674B476830644841364C79396D61584A6C6432397961334D7559574A6C595778734C6D4E7662536B674C6942575A584A7A615739754F6941774C6A59754D5341674C53302B44';
wwv_flow_api.g_varchar2_table(18) := '5477685245394456466C515253427A646D63675546564354456C44494349744C7939584D304D764C30525552434254566B63674D5334784C79394654694967496D6830644841364C79393364336375647A4D7562334A6E4C3064795958426F61574E7A4C';
wwv_flow_api.g_varchar2_table(19) := '314E57527938784C6A4576524652454C334E325A7A45784C6D52305A43492B4454787A646D636761575139496C567564476C306247566B4C5642685A32556C4D6A41784969423261575633516D393450534977494441674E6941324969427A64486C735A';
wwv_flow_api.g_varchar2_table(20) := '543069596D466A61326479623356755A43316A62327876636A6F6A5A6D5A6D5A6D5A6D4D44416949485A6C636E4E7062323439496A45754D53494E435868746247357A50534A6F644852774F693876643364334C6E637A4C6D39795A7938794D4441774C';
wwv_flow_api.g_varchar2_table(21) := '334E325A79496765473173626E4D3665477870626D7339496D6830644841364C79393364336375647A4D7562334A6E4C7A45354F546B7665477870626D7369494868746244707A6347466A5A54306963484A6C63325679646D556944516C345053497763';
wwv_flow_api.g_varchar2_table(22) := '48676949486B39496A42776543496764326C6B64476739496A5A7765434967614756705A32683050534932634867694454344E4354786E4947397759574E7064486B39496A41754D7A4179496A344E43516B38634746306143426B50534A4E494459674E';
wwv_flow_api.g_varchar2_table(23) := '69424D494441674E69424D494441674E433479494577674E4341304C6A4967544341304C6A49674E433479494577674E43347949444167544341324944416754434132494459675443413249445967576949675A6D6C7362443069497A41774D4441774D';
wwv_flow_api.g_varchar2_table(24) := '4349765067304A5043396E506730384C334E325A7A343D293B6261636B67726F756E642D706F736974696F6E3A746F70206C6566743B6261636B67726F756E642D7265706561743A6E6F2D7265706561743B637572736F723A73652D726573697A653B7A';
wwv_flow_api.g_varchar2_table(25) := '2D696E6465783A32307D2E67732D726573697A652D68616E646C652D787B746F703A303B626F74746F6D3A313370783B72696768743A2D3570783B77696474683A313070783B637572736F723A652D726573697A657D2E67732D726573697A652D68616E';
wwv_flow_api.g_varchar2_table(26) := '646C652D797B6C6566743A303B72696768743A313370783B626F74746F6D3A2D3570783B6865696768743A313070783B637572736F723A732D726573697A657D2E67732D773A686F766572202E67732D726573697A652D68616E646C652C2E726573697A';
wwv_flow_api.g_varchar2_table(27) := '696E67202E67732D726573697A652D68616E646C657B6F7061636974793A317D2E67732D726573697A652D68616E646C652C2E67732D772E6472616767696E67202E67732D726573697A652D68616E646C657B6F7061636974793A307D2E67732D726573';
wwv_flow_api.g_varchar2_table(28) := '697A652D64697361626C6564202E67732D726573697A652D68616E646C652C5B646174612D6D61782D73697A65783D2231225D202E67732D726573697A652D68616E646C652D782C5B646174612D6D61782D73697A65793D2231225D202E67732D726573';
wwv_flow_api.g_varchar2_table(29) := '697A652D68616E646C652D792C5B646174612D6D61782D73697A65793D2231225D5B646174612D6D61782D73697A65783D2231225D202E67732D726573697A652D68616E646C657B646973706C61793A6E6F6E6521696D706F7274616E747D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1629421061295803)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_file_name=>'jquery.dsmorse-gridster.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A212067726964737465722E6A73202D2076302E382E30202D20323031392D30312D3130202D202A2068747470733A2F2F64736D6F7273652E6769746875622E696F2F67726964737465722E6A732F202D20436F707972696768742028632920323031';
wwv_flow_api.g_varchar2_table(2) := '39206475636B73626F6172643B204C6963656E736564204D4954202A2F202166756E6374696F6E28612C62297B2275736520737472696374223B226F626A656374223D3D747970656F66206578706F7274733F6D6F64756C652E6578706F7274733D6228';
wwv_flow_api.g_varchar2_table(3) := '7265717569726528226A71756572792229293A2266756E6374696F6E223D3D747970656F6620646566696E652626646566696E652E616D643F646566696E65282267726964737465722D636F6F726473222C5B226A7175657279225D2C62293A612E4772';
wwv_flow_api.g_varchar2_table(4) := '696473746572436F6F7264733D6228612E247C7C612E6A5175657279297D28746869732C66756E6374696F6E2861297B2275736520737472696374223B66756E6374696F6E20622862297B72657475726E20625B305D2626612E6973506C61696E4F626A';
wwv_flow_api.g_varchar2_table(5) := '65637428625B305D293F746869732E646174613D625B305D3A746869732E656C3D622C746869732E6973436F6F7264733D21302C746869732E636F6F7264733D7B7D2C746869732E696E697428292C746869737D76617220633D622E70726F746F747970';
wwv_flow_api.g_varchar2_table(6) := '653B72657475726E20632E696E69743D66756E6374696F6E28297B746869732E73657428292C746869732E6F726967696E616C5F636F6F7264733D746869732E67657428297D2C632E7365743D66756E6374696F6E28612C62297B76617220633D746869';
wwv_flow_api.g_varchar2_table(7) := '732E656C3B6966286326262161262628746869732E646174613D632E6F666673657428292C746869732E646174612E77696474683D635B305D2E7363726F6C6C57696474682C746869732E646174612E6865696768743D635B305D2E7363726F6C6C4865';
wwv_flow_api.g_varchar2_table(8) := '69676874292C6326266126262162297B76617220643D632E6F666673657428293B746869732E646174612E746F703D642E746F702C746869732E646174612E6C6566743D642E6C6566747D76617220653D746869732E646174613B72657475726E20766F';
wwv_flow_api.g_varchar2_table(9) := '696420303D3D3D652E6C656674262628652E6C6566743D652E7831292C766F696420303D3D3D652E746F70262628652E746F703D652E7931292C746869732E636F6F7264732E78313D652E6C6566742C746869732E636F6F7264732E79313D652E746F70';
wwv_flow_api.g_varchar2_table(10) := '2C746869732E636F6F7264732E78323D652E6C6566742B652E77696474682C746869732E636F6F7264732E79323D652E746F702B652E6865696768742C746869732E636F6F7264732E63783D652E6C6566742B652E77696474682F322C746869732E636F';
wwv_flow_api.g_varchar2_table(11) := '6F7264732E63793D652E746F702B652E6865696768742F322C746869732E636F6F7264732E77696474683D652E77696474682C746869732E636F6F7264732E6865696768743D652E6865696768742C746869732E636F6F7264732E656C3D637C7C21312C';
wwv_flow_api.g_varchar2_table(12) := '746869737D2C632E7570646174653D66756E6374696F6E2862297B6966282162262621746869732E656C2972657475726E20746869733B69662862297B76617220633D612E657874656E64287B7D2C746869732E646174612C62293B72657475726E2074';
wwv_flow_api.g_varchar2_table(13) := '6869732E646174613D632C746869732E7365742821302C2130297D72657475726E20746869732E736574282130292C746869737D2C632E6765743D66756E6374696F6E28297B72657475726E20746869732E636F6F7264737D2C632E64657374726F793D';
wwv_flow_api.g_varchar2_table(14) := '66756E6374696F6E28297B746869732E656C2E72656D6F7665446174612822636F6F72647322292C64656C65746520746869732E656C7D2C612E666E2E636F6F7264733D66756E6374696F6E28297B696628746869732E646174612822636F6F72647322';
wwv_flow_api.g_varchar2_table(15) := '292972657475726E20746869732E646174612822636F6F72647322293B76617220613D6E657720622874686973293B72657475726E20746869732E646174612822636F6F726473222C61292C617D2C627D292C66756E6374696F6E28612C62297B227573';
wwv_flow_api.g_varchar2_table(16) := '6520737472696374223B226F626A656374223D3D747970656F66206578706F7274733F6D6F64756C652E6578706F7274733D62287265717569726528226A71756572792229293A2266756E6374696F6E223D3D747970656F6620646566696E6526266465';
wwv_flow_api.g_varchar2_table(17) := '66696E652E616D643F646566696E65282267726964737465722D636F6C6C6973696F6E222C5B226A7175657279222C2267726964737465722D636F6F726473225D2C62293A612E4772696473746572436F6C6C6973696F6E3D6228612E247C7C612E6A51';
wwv_flow_api.g_varchar2_table(18) := '756572792C612E4772696473746572436F6F726473297D28746869732C66756E6374696F6E28612C62297B2275736520737472696374223B66756E6374696F6E206328622C632C65297B746869732E6F7074696F6E733D612E657874656E6428642C6529';
wwv_flow_api.g_varchar2_table(19) := '2C746869732E24656C656D656E743D622C746869732E6C6173745F636F6C6C69646572733D5B5D2C746869732E6C6173745F636F6C6C69646572735F636F6F7264733D5B5D2C746869732E7365745F636F6C6C69646572732863292C746869732E696E69';
wwv_flow_api.g_varchar2_table(20) := '7428297D76617220643D7B636F6C6C69646572735F636F6E746578743A646F63756D656E742E626F64792C6F7665726C617070696E675F726567696F6E3A2243227D3B632E64656661756C74733D643B76617220653D632E70726F746F747970653B7265';
wwv_flow_api.g_varchar2_table(21) := '7475726E20652E696E69743D66756E6374696F6E28297B746869732E66696E645F636F6C6C6973696F6E7328297D2C652E6F7665726C6170733D66756E6374696F6E28612C62297B76617220633D21312C643D21313B72657475726E28622E78313E3D61';
wwv_flow_api.g_varchar2_table(22) := '2E78312626622E78313C3D612E78327C7C622E78323E3D612E78312626622E78323C3D612E78327C7C612E78313E3D622E78312626612E78323C3D622E783229262628633D2130292C28622E79313E3D612E79312626622E79313C3D612E79327C7C622E';
wwv_flow_api.g_varchar2_table(23) := '79323E3D612E79312626622E79323C3D612E79327C7C612E79313E3D622E79312626612E79323C3D622E793229262628643D2130292C632626647D2C652E6465746563745F6F7665726C617070696E675F726567696F6E3D66756E6374696F6E28612C62';
wwv_flow_api.g_varchar2_table(24) := '297B76617220633D22222C643D22223B72657475726E20612E79313E622E63792626612E79313C622E7932262628633D224E22292C612E79323E622E79312626612E79323C622E6379262628633D225322292C612E78313E622E63782626612E78313C62';
wwv_flow_api.g_varchar2_table(25) := '2E7832262628643D225722292C612E78323E622E78312626612E78323C622E6378262628643D224522292C632B647C7C2243227D2C652E63616C63756C6174655F6F7665726C61707065645F617265615F636F6F7264733D66756E6374696F6E28622C63';
wwv_flow_api.g_varchar2_table(26) := '297B76617220643D4D6174682E6D617828622E78312C632E7831292C653D4D6174682E6D617828622E79312C632E7931292C663D4D6174682E6D696E28622E78322C632E7832292C673D4D6174682E6D696E28622E79322C632E7932293B72657475726E';
wwv_flow_api.g_varchar2_table(27) := '2061287B6C6566743A642C746F703A652C77696474683A662D642C6865696768743A672D657D292E636F6F72647328292E67657428297D2C652E63616C63756C6174655F6F7665726C61707065645F617265613D66756E6374696F6E2861297B72657475';
wwv_flow_api.g_varchar2_table(28) := '726E20612E77696474682A612E6865696768747D2C652E6D616E6167655F636F6C6C69646572735F73746172745F73746F703D66756E6374696F6E28622C632C64297B666F722876617220653D746869732E6C6173745F636F6C6C69646572735F636F6F';
wwv_flow_api.g_varchar2_table(29) := '7264732C663D302C673D652E6C656E6774683B663C673B662B2B292D313D3D3D612E696E417272617928655B665D2C62292626632E63616C6C28746869732C655B665D293B666F722876617220683D302C693D622E6C656E6774683B683C693B682B2B29';
wwv_flow_api.g_varchar2_table(30) := '2D313D3D3D612E696E417272617928625B685D2C65292626642E63616C6C28746869732C625B685D297D2C652E66696E645F636F6C6C6973696F6E733D66756E6374696F6E2862297B666F722876617220633D746869732C643D746869732E6F7074696F';
wwv_flow_api.g_varchar2_table(31) := '6E732E6F7665726C617070696E675F726567696F6E2C653D5B5D2C663D5B5D2C673D746869732E636F6C6C69646572737C7C746869732E24636F6C6C69646572732C683D672E6C656E6774682C693D632E24656C656D656E742E636F6F72647328292E75';
wwv_flow_api.g_varchar2_table(32) := '706461746528627C7C2131292E67657428293B682D2D3B297B766172206A3D632E24636F6C6C69646572733F6128675B685D293A675B685D2C6B3D6A2E6973436F6F7264733F6A3A6A2E636F6F72647328292C6C3D6B2E67657428293B696628632E6F76';
wwv_flow_api.g_varchar2_table(33) := '65726C61707328692C6C29297B766172206D3D632E6465746563745F6F7665726C617070696E675F726567696F6E28692C6C293B6966286D3D3D3D647C7C22616C6C223D3D3D64297B766172206E3D632E63616C63756C6174655F6F7665726C61707065';
wwv_flow_api.g_varchar2_table(34) := '645F617265615F636F6F72647328692C6C292C6F3D632E63616C63756C6174655F6F7665726C61707065645F61726561286E293B69662830213D3D6F297B76617220703D7B617265613A6F2C617265615F636F6F7264733A6E2C726567696F6E3A6D2C63';
wwv_flow_api.g_varchar2_table(35) := '6F6F7264733A6C2C706C617965725F636F6F7264733A692C656C3A6A7D3B632E6F7074696F6E732E6F6E5F6F7665726C61702626632E6F7074696F6E732E6F6E5F6F7665726C61702E63616C6C28746869732C70292C652E70757368286B292C662E7075';
wwv_flow_api.g_varchar2_table(36) := '73682870297D7D7D7D72657475726E28632E6F7074696F6E732E6F6E5F6F7665726C61705F73746F707C7C632E6F7074696F6E732E6F6E5F6F7665726C61705F7374617274292626746869732E6D616E6167655F636F6C6C69646572735F73746172745F';
wwv_flow_api.g_varchar2_table(37) := '73746F7028652C632E6F7074696F6E732E6F6E5F6F7665726C61705F73746172742C632E6F7074696F6E732E6F6E5F6F7665726C61705F73746F70292C746869732E6C6173745F636F6C6C69646572735F636F6F7264733D652C667D2C652E6765745F63';
wwv_flow_api.g_varchar2_table(38) := '6C6F736573745F636F6C6C69646572733D66756E6374696F6E2861297B76617220623D746869732E66696E645F636F6C6C6973696F6E732861293B72657475726E20622E736F72742866756E6374696F6E28612C62297B72657475726E2243223D3D3D61';
wwv_flow_api.g_varchar2_table(39) := '2E726567696F6E26262243223D3D3D622E726567696F6E3F612E636F6F7264732E79313C622E636F6F7264732E79317C7C612E636F6F7264732E78313C622E636F6F7264732E78313F2D313A313A28612E617265612C622E617265612C31297D292C627D';
wwv_flow_api.g_varchar2_table(40) := '2C652E7365745F636F6C6C69646572733D66756E6374696F6E2862297B22737472696E67223D3D747970656F6620627C7C6220696E7374616E63656F6620613F746869732E24636F6C6C69646572733D6128622C746869732E6F7074696F6E732E636F6C';
wwv_flow_api.g_varchar2_table(41) := '6C69646572735F636F6E74657874292E6E6F7428746869732E24656C656D656E74293A746869732E636F6C6C69646572733D612862297D2C612E666E2E636F6C6C6973696F6E3D66756E6374696F6E28612C62297B72657475726E206E65772063287468';
wwv_flow_api.g_varchar2_table(42) := '69732C612C62297D2C637D292C66756E6374696F6E28612C62297B2275736520737472696374223B612E64656C61793D66756E6374696F6E28612C62297B76617220633D41727261792E70726F746F747970652E736C6963652E63616C6C28617267756D';
wwv_flow_api.g_varchar2_table(43) := '656E74732C32293B72657475726E2073657454696D656F75742866756E6374696F6E28297B72657475726E20612E6170706C79286E756C6C2C63297D2C62297D2C612E6465626F756E63653D66756E6374696F6E28612C622C63297B76617220643B7265';
wwv_flow_api.g_varchar2_table(44) := '7475726E2066756E6374696F6E28297B76617220653D746869732C663D617267756D656E74732C673D66756E6374696F6E28297B643D6E756C6C2C637C7C612E6170706C7928652C66297D3B63262621642626612E6170706C7928652C66292C636C6561';
wwv_flow_api.g_varchar2_table(45) := '7254696D656F75742864292C643D73657454696D656F757428672C62297D7D2C612E7468726F74746C653D66756E6374696F6E28612C62297B76617220632C642C652C662C672C682C693D6465626F756E63652866756E6374696F6E28297B673D663D21';
wwv_flow_api.g_varchar2_table(46) := '317D2C62293B72657475726E2066756E6374696F6E28297B633D746869732C643D617267756D656E74733B766172206A3D66756E6374696F6E28297B653D6E756C6C2C672626612E6170706C7928632C64292C6928297D3B72657475726E20657C7C2865';
wwv_flow_api.g_varchar2_table(47) := '3D73657454696D656F7574286A2C6229292C663F673D21303A683D612E6170706C7928632C64292C6928292C663D21302C687D7D7D2877696E646F77292C66756E6374696F6E28612C62297B2275736520737472696374223B226F626A656374223D3D74';
wwv_flow_api.g_varchar2_table(48) := '7970656F66206578706F7274733F6D6F64756C652E6578706F7274733D62287265717569726528226A71756572792229293A2266756E6374696F6E223D3D747970656F6620646566696E652626646566696E652E616D643F646566696E65282267726964';
wwv_flow_api.g_varchar2_table(49) := '737465722D647261676761626C65222C5B226A7175657279225D2C62293A612E4772696473746572447261676761626C653D6228612E247C7C612E6A5175657279297D28746869732C66756E6374696F6E2861297B2275736520737472696374223B6675';
wwv_flow_api.g_varchar2_table(50) := '6E6374696F6E206228622C64297B746869732E6F7074696F6E733D612E657874656E64287B7D2C632C64292C746869732E24646F63756D656E743D6128646F63756D656E74292C746869732E24636F6E7461696E65723D612862292C746869732E247363';
wwv_flow_api.g_varchar2_table(51) := '726F6C6C5F636F6E7461696E65723D746869732E6F7074696F6E732E7363726F6C6C5F636F6E7461696E65723D3D3D77696E646F773F612877696E646F77293A746869732E24636F6E7461696E65722E636C6F7365737428746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(52) := '2E7363726F6C6C5F636F6E7461696E6572292C746869732E69735F6472616767696E673D21312C746869732E706C617965725F6D696E5F6C6566743D302B746869732E6F7074696F6E732E6F66667365745F6C6566742C746869732E706C617965725F6D';
wwv_flow_api.g_varchar2_table(53) := '696E5F746F703D302B746869732E6F7074696F6E732E6F66667365745F746F702C746869732E69643D6928292C746869732E6E733D222E67726964737465722D647261676761626C652D222B746869732E69642C746869732E696E697428297D76617220';
wwv_flow_api.g_varchar2_table(54) := '633D7B6974656D733A226C69222C64697374616E63653A312C6C696D69743A7B77696474683A21302C6865696768743A21317D2C6F66667365745F6C6566743A302C6175746F7363726F6C6C3A21302C69676E6F72655F6472616767696E673A5B22494E';
wwv_flow_api.g_varchar2_table(55) := '505554222C225445585441524541222C2253454C454354222C22425554544F4E225D2C68616E646C653A6E756C6C2C636F6E7461696E65725F77696474683A302C6D6F76655F656C656D656E743A21302C68656C7065723A21312C72656D6F76655F6865';
wwv_flow_api.g_varchar2_table(56) := '6C7065723A21307D2C643D612877696E646F77292C653D7B783A226C656674222C793A22746F70227D2C663D212128226F6E746F756368737461727422696E2077696E646F77292C673D66756E6374696F6E2861297B72657475726E20612E6368617241';
wwv_flow_api.g_varchar2_table(57) := '742830292E746F55707065724361736528292B612E736C6963652831297D2C683D302C693D66756E6374696F6E28297B72657475726E2B2B682B22227D3B622E64656661756C74733D633B766172206A3D622E70726F746F747970653B72657475726E20';
wwv_flow_api.g_varchar2_table(58) := '6A2E696E69743D66756E6374696F6E28297B76617220623D746869732E24636F6E7461696E65722E6373732822706F736974696F6E22293B746869732E63616C63756C6174655F64696D656E73696F6E7328292C746869732E24636F6E7461696E65722E';
wwv_flow_api.g_varchar2_table(59) := '6373732822706F736974696F6E222C22737461746963223D3D3D623F2272656C6174697665223A62292C746869732E64697361626C65643D21312C746869732E6576656E747328292C642E62696E6428746869732E6E734576656E742822726573697A65';
wwv_flow_api.g_varchar2_table(60) := '22292C7468726F74746C6528612E70726F787928746869732E63616C63756C6174655F64696D656E73696F6E732C74686973292C32303029297D2C6A2E6E734576656E743D66756E6374696F6E2861297B72657475726E28617C7C2222292B746869732E';
wwv_flow_api.g_varchar2_table(61) := '6E737D2C6A2E6576656E74733D66756E6374696F6E28297B746869732E706F696E7465725F6576656E74733D7B73746172743A746869732E6E734576656E742822746F756368737461727422292B2220222B746869732E6E734576656E7428226D6F7573';
wwv_flow_api.g_varchar2_table(62) := '65646F776E22292C6D6F76653A746869732E6E734576656E742822746F7563686D6F766522292B2220222B746869732E6E734576656E7428226D6F7573656D6F766522292C656E643A746869732E6E734576656E742822746F756368656E6422292B2220';
wwv_flow_api.g_varchar2_table(63) := '222B746869732E6E734576656E7428226D6F757365757022297D2C746869732E24636F6E7461696E65722E6F6E28746869732E6E734576656E74282273656C656374737461727422292C612E70726F787928746869732E6F6E5F73656C6563745F737461';
wwv_flow_api.g_varchar2_table(64) := '72742C7468697329292C746869732E24636F6E7461696E65722E6F6E28746869732E706F696E7465725F6576656E74732E73746172742C746869732E6F7074696F6E732E6974656D732C612E70726F787928746869732E647261675F68616E646C65722C';
wwv_flow_api.g_varchar2_table(65) := '7468697329292C746869732E24646F63756D656E742E6F6E28746869732E706F696E7465725F6576656E74732E656E642C612E70726F78792866756E6374696F6E2861297B746869732E69735F6472616767696E673D21312C746869732E64697361626C';
wwv_flow_api.g_varchar2_table(66) := '65647C7C28746869732E24646F63756D656E742E6F666628746869732E706F696E7465725F6576656E74732E6D6F7665292C746869732E647261675F73746172742626746869732E6F6E5F6472616773746F70286129297D2C7468697329297D2C6A2E67';
wwv_flow_api.g_varchar2_table(67) := '65745F61637475616C5F706F733D66756E6374696F6E2861297B72657475726E20612E706F736974696F6E28297D2C6A2E6765745F6D6F7573655F706F733D66756E6374696F6E2861297B696628612E6F726967696E616C4576656E742626612E6F7269';
wwv_flow_api.g_varchar2_table(68) := '67696E616C4576656E742E746F7563686573297B76617220623D612E6F726967696E616C4576656E743B613D622E746F75636865732E6C656E6774683F622E746F75636865735B305D3A622E6368616E676564546F75636865735B305D7D72657475726E';
wwv_flow_api.g_varchar2_table(69) := '7B6C6566743A612E636C69656E74582C746F703A612E636C69656E74597D7D2C6A2E6765745F6F66667365743D66756E6374696F6E2861297B612E70726576656E7444656661756C7428293B76617220623D746869732E6765745F6D6F7573655F706F73';
wwv_flow_api.g_varchar2_table(70) := '2861292C633D4D6174682E726F756E6428622E6C6566742D746869732E6D6F7573655F696E69745F706F732E6C656674292C643D4D6174682E726F756E6428622E746F702D746869732E6D6F7573655F696E69745F706F732E746F70292C653D4D617468';
wwv_flow_api.g_varchar2_table(71) := '2E726F756E6428746869732E656C5F696E69745F6F66667365742E6C6566742B632D746869732E62617365582B746869732E247363726F6C6C5F636F6E7461696E65722E7363726F6C6C4C65667428292D746869732E7363726F6C6C5F636F6E7461696E';
wwv_flow_api.g_varchar2_table(72) := '65725F6F66667365745F78292C663D4D6174682E726F756E6428746869732E656C5F696E69745F6F66667365742E746F702B642D746869732E62617365592B746869732E247363726F6C6C5F636F6E7461696E65722E7363726F6C6C546F7028292D7468';
wwv_flow_api.g_varchar2_table(73) := '69732E7363726F6C6C5F636F6E7461696E65725F6F66667365745F79293B72657475726E20746869732E6F7074696F6E732E6C696D69742E7769647468262628653E746869732E706C617965725F6D61785F6C6566743F653D746869732E706C61796572';
wwv_flow_api.g_varchar2_table(74) := '5F6D61785F6C6566743A653C746869732E706C617965725F6D696E5F6C656674262628653D746869732E706C617965725F6D696E5F6C65667429292C746869732E6F7074696F6E732E6C696D69742E686569676874262628663E746869732E706C617965';
wwv_flow_api.g_varchar2_table(75) := '725F6D61785F746F703F663D746869732E706C617965725F6D61785F746F703A663C746869732E706C617965725F6D696E5F746F70262628663D746869732E706C617965725F6D696E5F746F7029292C7B706F736974696F6E3A7B6C6566743A652C746F';
wwv_flow_api.g_varchar2_table(76) := '703A667D2C706F696E7465723A7B6C6566743A622E6C6566742C746F703A622E746F702C646966665F6C6566743A632B28746869732E247363726F6C6C5F636F6E7461696E65722E7363726F6C6C4C65667428292D746869732E7363726F6C6C5F636F6E';
wwv_flow_api.g_varchar2_table(77) := '7461696E65725F6F66667365745F78292C646966665F746F703A642B28746869732E247363726F6C6C5F636F6E7461696E65722E7363726F6C6C546F7028292D746869732E7363726F6C6C5F636F6E7461696E65725F6F66667365745F79297D7D7D2C6A';
wwv_flow_api.g_varchar2_table(78) := '2E6765745F647261675F646174613D66756E6374696F6E2861297B76617220623D746869732E6765745F6F66667365742861293B72657475726E20622E24706C617965723D746869732E24706C617965722C622E2468656C7065723D746869732E68656C';
wwv_flow_api.g_varchar2_table(79) := '7065723F746869732E2468656C7065723A746869732E24706C617965722C627D2C6A2E7365745F6C696D6974733D66756E6374696F6E2861297B72657475726E20617C7C28613D746869732E24636F6E7461696E65722E77696474682829292C74686973';
wwv_flow_api.g_varchar2_table(80) := '2E706C617965725F6D61785F6C6566743D612D746869732E706C617965725F77696474682D746869732E6F7074696F6E732E6F66667365745F6C6566742C746869732E706C617965725F6D61785F746F703D746869732E6F7074696F6E732E636F6E7461';
wwv_flow_api.g_varchar2_table(81) := '696E65725F6865696768742D746869732E706C617965725F6865696768742D746869732E6F7074696F6E732E6F66667365745F746F702C746869732E6F7074696F6E732E636F6E7461696E65725F77696474683D612C746869737D2C6A2E7363726F6C6C';
wwv_flow_api.g_varchar2_table(82) := '5F696E3D66756E6374696F6E28612C62297B76617220632C643D655B615D2C663D35302C683D33302C693D227363726F6C6C222B672864292C6A3D2278223D3D3D612C6B3D6A3F746869732E7363726F6C6C65725F77696474683A746869732E7363726F';
wwv_flow_api.g_varchar2_table(83) := '6C6C65725F6865696768743B633D746869732E247363726F6C6C5F636F6E7461696E65723D3D3D77696E646F773F6A3F746869732E247363726F6C6C5F636F6E7461696E65722E776964746828293A746869732E247363726F6C6C5F636F6E7461696E65';
wwv_flow_api.g_varchar2_table(84) := '722E68656967687428293A6A3F746869732E247363726F6C6C5F636F6E7461696E65725B305D2E7363726F6C6C57696474683A746869732E247363726F6C6C5F636F6E7461696E65725B305D2E7363726F6C6C4865696768743B766172206C2C6D3D6A3F';
wwv_flow_api.g_varchar2_table(85) := '746869732E24706C617965722E776964746828293A746869732E24706C617965722E68656967687428292C6E3D746869732E247363726F6C6C5F636F6E7461696E65725B695D28292C6F3D6E2C703D6F2B6B2C713D702D662C723D6F2B662C733D6F2B62';
wwv_flow_api.g_varchar2_table(86) := '2E706F696E7465725B645D2C743D632D6B2B6D3B72657475726E20733E3D712626286C3D6E2B68293C74262628746869732E247363726F6C6C5F636F6E7461696E65725B695D286C292C746869735B227363726F6C6C5F6F66667365745F222B615D2B3D';
wwv_flow_api.g_varchar2_table(87) := '68292C733C3D722626286C3D6E2D68293E30262628746869732E247363726F6C6C5F636F6E7461696E65725B695D286C292C746869735B227363726F6C6C5F6F66667365745F222B615D2D3D68292C746869737D2C6A2E6D616E6167655F7363726F6C6C';
wwv_flow_api.g_varchar2_table(88) := '3D66756E6374696F6E2861297B746869732E7363726F6C6C5F696E282278222C61292C746869732E7363726F6C6C5F696E282279222C61297D2C6A2E63616C63756C6174655F64696D656E73696F6E733D66756E6374696F6E28297B746869732E736372';
wwv_flow_api.g_varchar2_table(89) := '6F6C6C65725F6865696768743D746869732E247363726F6C6C5F636F6E7461696E65722E68656967687428292C746869732E7363726F6C6C65725F77696474683D746869732E247363726F6C6C5F636F6E7461696E65722E776964746828297D2C6A2E64';
wwv_flow_api.g_varchar2_table(90) := '7261675F68616E646C65723D66756E6374696F6E2862297B69662821746869732E64697361626C6564262628313D3D3D622E77686963687C7C6629262621746869732E69676E6F72655F64726167286229297B76617220633D746869732C643D21303B72';
wwv_flow_api.g_varchar2_table(91) := '657475726E20746869732E24706C617965723D6128622E63757272656E74546172676574292C746869732E656C5F696E69745F706F733D746869732E6765745F61637475616C5F706F7328746869732E24706C61796572292C746869732E6D6F7573655F';
wwv_flow_api.g_varchar2_table(92) := '696E69745F706F733D746869732E6765745F6D6F7573655F706F732862292C746869732E6F6666736574593D746869732E6D6F7573655F696E69745F706F732E746F702D746869732E656C5F696E69745F706F732E746F702C746869732E24646F63756D';
wwv_flow_api.g_varchar2_table(93) := '656E742E6F6E28746869732E706F696E7465725F6576656E74732E6D6F76652C66756E6374696F6E2861297B76617220623D632E6765745F6D6F7573655F706F732861292C653D4D6174682E61627328622E6C6566742D632E6D6F7573655F696E69745F';
wwv_flow_api.g_varchar2_table(94) := '706F732E6C656674292C663D4D6174682E61627328622E746F702D632E6D6F7573655F696E69745F706F732E746F70293B72657475726E28653E632E6F7074696F6E732E64697374616E63657C7C663E632E6F7074696F6E732E64697374616E63652926';
wwv_flow_api.g_varchar2_table(95) := '2628643F28643D21312C632E6F6E5F6472616773746172742E63616C6C28632C61292C2131293A2821303D3D3D632E69735F6472616767696E672626632E6F6E5F647261676D6F76652E63616C6C28632C61292C213129297D292C2121662626766F6964';
wwv_flow_api.g_varchar2_table(96) := '20307D7D2C6A2E6F6E5F6472616773746172743D66756E6374696F6E2861297B696628612E70726576656E7444656661756C7428292C746869732E69735F6472616767696E672972657475726E20746869733B746869732E647261675F73746172743D74';
wwv_flow_api.g_varchar2_table(97) := '6869732E69735F6472616767696E673D21303B76617220623D746869732E24636F6E7461696E65722E6F666673657428293B72657475726E20746869732E62617365583D4D6174682E726F756E6428622E6C656674292C746869732E62617365593D4D61';
wwv_flow_api.g_varchar2_table(98) := '74682E726F756E6428622E746F70292C22636C6F6E65223D3D3D746869732E6F7074696F6E732E68656C7065723F28746869732E2468656C7065723D746869732E24706C617965722E636C6F6E6528292E617070656E64546F28746869732E24636F6E74';
wwv_flow_api.g_varchar2_table(99) := '61696E6572292E616464436C617373282268656C70657222292C746869732E68656C7065723D2130293A746869732E68656C7065723D21312C746869732E7363726F6C6C5F636F6E7461696E65725F6F66667365745F793D746869732E247363726F6C6C';
wwv_flow_api.g_varchar2_table(100) := '5F636F6E7461696E65722E7363726F6C6C546F7028292C746869732E7363726F6C6C5F636F6E7461696E65725F6F66667365745F783D746869732E247363726F6C6C5F636F6E7461696E65722E7363726F6C6C4C65667428292C746869732E656C5F696E';
wwv_flow_api.g_varchar2_table(101) := '69745F6F66667365743D746869732E24706C617965722E6F666673657428292C746869732E706C617965725F77696474683D746869732E24706C617965722E776964746828292C746869732E706C617965725F6865696768743D746869732E24706C6179';
wwv_flow_api.g_varchar2_table(102) := '65722E68656967687428292C746869732E7365745F6C696D69747328746869732E6F7074696F6E732E636F6E7461696E65725F7769647468292C746869732E6F7074696F6E732E73746172742626746869732E6F7074696F6E732E73746172742E63616C';
wwv_flow_api.g_varchar2_table(103) := '6C28746869732E24706C617965722C612C746869732E6765745F647261675F64617461286129292C21317D2C6A2E6F6E5F647261676D6F76653D66756E6374696F6E2861297B76617220623D746869732E6765745F647261675F646174612861293B7468';
wwv_flow_api.g_varchar2_table(104) := '69732E6F7074696F6E732E6175746F7363726F6C6C2626746869732E6D616E6167655F7363726F6C6C2862292C746869732E6F7074696F6E732E6D6F76655F656C656D656E74262628746869732E68656C7065723F746869732E2468656C7065723A7468';
wwv_flow_api.g_varchar2_table(105) := '69732E24706C61796572292E637373287B706F736974696F6E3A226162736F6C757465222C6C6566743A622E706F736974696F6E2E6C6566742C746F703A622E706F736974696F6E2E746F707D293B76617220633D746869732E6C6173745F706F736974';
wwv_flow_api.g_varchar2_table(106) := '696F6E7C7C622E706F736974696F6E3B72657475726E20622E707265765F706F736974696F6E3D632C746869732E6F7074696F6E732E647261672626746869732E6F7074696F6E732E647261672E63616C6C28746869732E24706C617965722C612C6229';
wwv_flow_api.g_varchar2_table(107) := '2C746869732E6C6173745F706F736974696F6E3D622E706F736974696F6E2C21317D2C6A2E6F6E5F6472616773746F703D66756E6374696F6E2861297B76617220623D746869732E6765745F647261675F646174612861293B72657475726E2074686973';
wwv_flow_api.g_varchar2_table(108) := '2E647261675F73746172743D21312C746869732E6F7074696F6E732E73746F702626746869732E6F7074696F6E732E73746F702E63616C6C28746869732E24706C617965722C612C62292C746869732E68656C7065722626746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(109) := '2E72656D6F76655F68656C7065722626746869732E2468656C7065722E72656D6F766528292C21317D2C6A2E6F6E5F73656C6563745F73746172743D66756E6374696F6E2861297B69662821746869732E64697361626C6564262621746869732E69676E';
wwv_flow_api.g_varchar2_table(110) := '6F72655F647261672861292972657475726E21317D2C6A2E656E61626C653D66756E6374696F6E28297B746869732E64697361626C65643D21317D2C6A2E64697361626C653D66756E6374696F6E28297B746869732E64697361626C65643D21307D2C6A';
wwv_flow_api.g_varchar2_table(111) := '2E64657374726F793D66756E6374696F6E28297B746869732E64697361626C6528292C746869732E24636F6E7461696E65722E6F666628746869732E6E73292C746869732E24646F63756D656E742E6F666628746869732E6E73292C642E6F6666287468';
wwv_flow_api.g_varchar2_table(112) := '69732E6E73292C612E72656D6F76654461746128746869732E24636F6E7461696E65722C226472616722297D2C6A2E69676E6F72655F647261673D66756E6374696F6E2862297B72657475726E20746869732E6F7074696F6E732E68616E646C653F2161';
wwv_flow_api.g_varchar2_table(113) := '28622E746172676574292E697328746869732E6F7074696F6E732E68616E646C65293A612E697346756E6374696F6E28746869732E6F7074696F6E732E69676E6F72655F6472616767696E67293F746869732E6F7074696F6E732E69676E6F72655F6472';
wwv_flow_api.g_varchar2_table(114) := '616767696E672862293A746869732E6F7074696F6E732E726573697A653F216128622E746172676574292E697328746869732E6F7074696F6E732E6974656D73293A6128622E746172676574292E697328746869732E6F7074696F6E732E69676E6F7265';
wwv_flow_api.g_varchar2_table(115) := '5F6472616767696E672E6A6F696E28222C202229297D2C612E666E2E67726964447261676761626C653D66756E6374696F6E2861297B72657475726E206E6577206228746869732C61297D2C612E666E2E64726167673D66756E6374696F6E2863297B72';
wwv_flow_api.g_varchar2_table(116) := '657475726E20746869732E656163682866756E6374696F6E28297B612E6461746128746869732C226472616722297C7C612E6461746128746869732C2264726167222C6E6577206228746869732C6329297D297D2C627D292C66756E6374696F6E28612C';
wwv_flow_api.g_varchar2_table(117) := '62297B2275736520737472696374223B226F626A656374223D3D747970656F66206578706F7274733F6D6F64756C652E6578706F7274733D62287265717569726528226A717565727922292C7265717569726528222E2F6A71756572792E647261676761';
wwv_flow_api.g_varchar2_table(118) := '626C652E6A7322292C7265717569726528222E2F6A71756572792E636F6C6C6973696F6E2E6A7322292C7265717569726528222E2F6A71756572792E636F6F7264732E6A7322292C7265717569726528222E2F7574696C732E6A732229293A2266756E63';
wwv_flow_api.g_varchar2_table(119) := '74696F6E223D3D747970656F6620646566696E652626646566696E652E616D643F646566696E65285B226A7175657279222C2267726964737465722D647261676761626C65222C2267726964737465722D636F6C6C6973696F6E225D2C62293A612E4772';
wwv_flow_api.g_varchar2_table(120) := '6964737465723D6228612E247C7C612E6A51756572792C612E4772696473746572447261676761626C652C612E4772696473746572436F6C6C6973696F6E297D28746869732C66756E6374696F6E28612C622C63297B2275736520737472696374223B66';
wwv_flow_api.g_varchar2_table(121) := '756E6374696F6E206428622C63297B746869732E6F7074696F6E733D612E657874656E642821302C7B7D2C672C63292C746869732E6F7074696F6E732E647261676761626C653D746869732E6F7074696F6E732E647261676761626C657C7C7B7D2C7468';
wwv_flow_api.g_varchar2_table(122) := '69732E6F7074696F6E732E647261676761626C653D612E657874656E642821302C7B7D2C746869732E6F7074696F6E732E647261676761626C652C7B7363726F6C6C5F636F6E7461696E65723A746869732E6F7074696F6E732E7363726F6C6C5F636F6E';
wwv_flow_api.g_varchar2_table(123) := '7461696E65727D292C746869732E24656C3D612862292C746869732E247363726F6C6C5F636F6E7461696E65723D746869732E6F7074696F6E732E7363726F6C6C5F636F6E7461696E65723D3D3D77696E646F773F612877696E646F77293A746869732E';
wwv_flow_api.g_varchar2_table(124) := '24656C2E636C6F7365737428746869732E6F7074696F6E732E7363726F6C6C5F636F6E7461696E6572292C746869732E24777261707065723D746869732E24656C2E706172656E7428292C746869732E24776964676574733D746869732E24656C2E6368';
wwv_flow_api.g_varchar2_table(125) := '696C6472656E28746869732E6F7074696F6E732E7769646765745F73656C6563746F72292E616464436C617373282267732D7722292C746869732E246368616E6765643D61285B5D292C746869732E775F71756575653D7B7D2C746869732E69735F7265';
wwv_flow_api.g_varchar2_table(126) := '73706F6E7369766528293F746869732E6D696E5F7769646765745F77696474683D746869732E6765745F726573706F6E736976655F636F6C5F776964746828293A746869732E6D696E5F7769646765745F77696474683D746869732E6F7074696F6E732E';
wwv_flow_api.g_varchar2_table(127) := '7769646765745F626173655F64696D656E73696F6E735B305D2C746869732E6D696E5F7769646765745F6865696768743D746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E735B315D2C746869732E69735F72657369';
wwv_flow_api.g_varchar2_table(128) := '7A696E673D21312C746869732E6D696E5F636F6C5F636F756E743D746869732E6F7074696F6E732E6D696E5F636F6C732C746869732E707265765F636F6C5F636F756E743D746869732E6D696E5F636F6C5F636F756E742C746869732E67656E65726174';
wwv_flow_api.g_varchar2_table(129) := '65645F7374796C657368656574733D5B5D2C746869732E247374796C655F746167733D61285B5D292C747970656F6620746869732E6F7074696F6E732E6C696D69743D3D747970656F662130262628636F6E736F6C652E6C6F6728226C696D69743A2062';
wwv_flow_api.g_varchar2_table(130) := '6F6F6C20697320646570726563617465642C20636F6E7369646572207573696E67206C696D69743A207B2077696474683A20626F6F6C65616E2C206865696768743A20626F6F6C65616E7D20696E737465616422292C746869732E6F7074696F6E732E6C';
wwv_flow_api.g_varchar2_table(131) := '696D69743D7B77696474683A746869732E6F7074696F6E732E6C696D69742C6865696768743A746869732E6F7074696F6E732E6C696D69747D292C746869732E6F7074696F6E732E6175746F5F696E69742626746869732E696E697428297D66756E6374';
wwv_flow_api.g_varchar2_table(132) := '696F6E20652861297B666F722876617220623D5B22636F6C222C22726F77222C2273697A655F78222C2273697A655F79225D2C633D7B7D2C643D302C653D622E6C656E6774683B643C653B642B2B297B76617220663D625B645D3B69662821286620696E';
wwv_flow_api.g_varchar2_table(133) := '206129297468726F77206E6577204572726F7228224E6F74206578697374732070726F70657274792060222B662B226022293B76617220673D615B665D3B69662821677C7C69734E614E286729297468726F77206E6577204572726F722822496E76616C';
wwv_flow_api.g_varchar2_table(134) := '69642076616C7565206F662060222B662B22602070726F706572747922293B635B665D3D2B677D72657475726E20637D76617220663D612877696E646F77292C673D7B6E616D6573706163653A22222C7769646765745F73656C6563746F723A226C6922';
wwv_flow_api.g_varchar2_table(135) := '2C7374617469635F636C6173733A22737461746963222C7769646765745F6D617267696E733A5B31302C31305D2C7769646765745F626173655F64696D656E73696F6E733A5B3430302C3232355D2C65787472615F726F77733A302C65787472615F636F';
wwv_flow_api.g_varchar2_table(136) := '6C733A302C6D696E5F636F6C733A312C6D61785F636F6C733A312F302C6C696D69743A7B77696474683A21302C6865696768743A21317D2C6D696E5F726F77733A312C6D61785F726F77733A31352C6175746F67656E65726174655F7374796C65736865';
wwv_flow_api.g_varchar2_table(137) := '65743A21302C61766F69645F6F7665726C61707065645F776964676574733A21302C6175746F5F696E69743A21302C63656E7465725F776964676574733A21312C726573706F6E736976655F627265616B706F696E743A21312C7363726F6C6C5F636F6E';
wwv_flow_api.g_varchar2_table(138) := '7461696E65723A77696E646F772C73686966745F6C61726765725F776964676574735F646F776E3A21302C6D6F76655F776964676574735F646F776E5F6F6E6C793A21312C73686966745F776964676574735F75703A21302C73686F775F656C656D656E';
wwv_flow_api.g_varchar2_table(139) := '743A66756E6374696F6E28612C62297B623F612E66616465496E2862293A612E66616465496E28297D2C686964655F656C656D656E743A66756E6374696F6E28612C62297B623F612E666164654F75742862293A612E666164654F757428297D2C736572';
wwv_flow_api.g_varchar2_table(140) := '69616C697A655F706172616D733A66756E6374696F6E28612C62297B72657475726E7B636F6C3A622E636F6C2C726F773A622E726F772C73697A655F783A622E73697A655F782C73697A655F793A622E73697A655F797D7D2C636F6C6C6973696F6E3A7B';
wwv_flow_api.g_varchar2_table(141) := '776169745F666F725F6D6F75736575703A21317D2C647261676761626C653A7B6974656D733A222E67732D773A6E6F74282E73746174696329222C64697374616E63653A342C69676E6F72655F6472616767696E673A622E64656661756C74732E69676E';
wwv_flow_api.g_varchar2_table(142) := '6F72655F6472616767696E672E736C6963652830297D2C726573697A653A7B656E61626C65643A21312C617865733A5B22626F7468225D2C68616E646C655F617070656E645F746F3A22222C68616E646C655F636C6173733A2267732D726573697A652D';
wwv_flow_api.g_varchar2_table(143) := '68616E646C65222C6D61785F73697A653A5B312F302C312F305D2C6D696E5F73697A653A5B312C315D7D2C69676E6F72655F73656C665F6F636375706965643A21317D3B642E64656661756C74733D672C642E67656E6572617465645F7374796C657368';
wwv_flow_api.g_varchar2_table(144) := '656574733D5B5D2C642E736F72745F62795F726F775F6173633D66756E6374696F6E2862297B72657475726E20623D622E736F72742866756E6374696F6E28622C63297B72657475726E20622E726F777C7C28623D612862292E636F6F72647328292E67';
wwv_flow_api.g_varchar2_table(145) := '7269642C633D612863292E636F6F72647328292E67726964292C623D652862292C633D652863292C622E726F773E632E726F773F313A2D317D297D2C642E736F72745F62795F726F775F616E645F636F6C5F6173633D66756E6374696F6E2861297B7265';
wwv_flow_api.g_varchar2_table(146) := '7475726E20613D612E736F72742866756E6374696F6E28612C62297B72657475726E20613D652861292C623D652862292C612E726F773E622E726F777C7C612E726F773D3D3D622E726F772626612E636F6C3E622E636F6C3F313A2D317D297D2C642E73';
wwv_flow_api.g_varchar2_table(147) := '6F72745F62795F636F6C5F6173633D66756E6374696F6E2861297B72657475726E20613D612E736F72742866756E6374696F6E28612C62297B72657475726E20613D652861292C623D652862292C612E636F6C3E622E636F6C3F313A2D317D297D2C642E';
wwv_flow_api.g_varchar2_table(148) := '736F72745F62795F726F775F646573633D66756E6374696F6E2861297B72657475726E20613D612E736F72742866756E6374696F6E28612C62297B72657475726E20613D652861292C623D652862292C612E726F772B612E73697A655F793C622E726F77';
wwv_flow_api.g_varchar2_table(149) := '2B622E73697A655F793F313A2D317D297D3B76617220683D642E70726F746F747970653B72657475726E20682E696E69743D66756E6374696F6E28297B746869732E6F7074696F6E732E726573697A652E656E61626C65642626746869732E7365747570';
wwv_flow_api.g_varchar2_table(150) := '5F726573697A6528292C746869732E67656E65726174655F677269645F616E645F7374796C65736865657428292C746869732E6765745F776964676574735F66726F6D5F444F4D28292C746869732E7365745F646F6D5F677269645F6865696768742829';
wwv_flow_api.g_varchar2_table(151) := '2C746869732E7365745F646F6D5F677269645F776964746828292C746869732E24777261707065722E616464436C6173732822726561647922292C746869732E647261676761626C6528292C746869732E6F7074696F6E732E726573697A652E656E6162';
wwv_flow_api.g_varchar2_table(152) := '6C65642626746869732E726573697A61626C6528292C746869732E6F7074696F6E732E63656E7465725F77696467657473262673657454696D656F757428612E70726F78792866756E6374696F6E28297B746869732E63656E7465725F77696467657473';
wwv_flow_api.g_varchar2_table(153) := '28297D2C74686973292C30292C662E62696E642822726573697A652E6772696473746572222C7468726F74746C6528612E70726F787928746869732E726563616C63756C6174655F666175785F677269642C74686973292C32303029297D2C682E646973';
wwv_flow_api.g_varchar2_table(154) := '61626C653D66756E6374696F6E28297B72657475726E20746869732E24777261707065722E66696E6428222E706C617965722D72657665727422292E72656D6F7665436C6173732822706C617965722D72657665727422292C746869732E647261675F61';
wwv_flow_api.g_varchar2_table(155) := '70692E64697361626C6528292C746869737D2C682E656E61626C653D66756E6374696F6E28297B72657475726E20746869732E647261675F6170692E656E61626C6528292C746869737D2C682E64697361626C655F726573697A653D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(156) := '28297B72657475726E20746869732E24656C2E616464436C617373282267732D726573697A652D64697361626C656422292C746869732E726573697A655F6170692E64697361626C6528292C746869737D2C682E656E61626C655F726573697A653D6675';
wwv_flow_api.g_varchar2_table(157) := '6E6374696F6E28297B72657475726E20746869732E24656C2E72656D6F7665436C617373282267732D726573697A652D64697361626C656422292C746869732E726573697A655F6170692E656E61626C6528292C746869737D2C682E6164645F77696467';
wwv_flow_api.g_varchar2_table(158) := '65743D66756E6374696F6E28622C632C642C652C662C672C682C69297B766172206A3B696628637C7C28633D31292C647C7C28643D31292C657C7C66296A3D7B636F6C3A652C726F773A662C73697A655F783A632C73697A655F793A647D2C746869732E';
wwv_flow_api.g_varchar2_table(159) := '6F7074696F6E732E61766F69645F6F7665726C61707065645F776964676574732626746869732E656D7074795F63656C6C7328652C662C632C64293B656C73652069662821313D3D3D286A3D746869732E6E6578745F706F736974696F6E28632C642929';
wwv_flow_api.g_varchar2_table(160) := '2972657475726E21313B766172206B3D612862292E61747472287B22646174612D636F6C223A6A2E636F6C2C22646174612D726F77223A6A2E726F772C22646174612D73697A6578223A632C22646174612D73697A6579223A647D292E616464436C6173';
wwv_flow_api.g_varchar2_table(161) := '73282267732D7722292E617070656E64546F28746869732E24656C292E6869646528293B746869732E24776964676574733D746869732E24776964676574732E616464286B292C746869732E246368616E6765643D746869732E246368616E6765642E61';
wwv_flow_api.g_varchar2_table(162) := '6464286B292C746869732E72656769737465725F776964676574286B293B766172206C3D7061727365496E74286A2E726F77292B287061727365496E74286A2E73697A655F79292D31293B72657475726E20746869732E726F77733C6C2626746869732E';
wwv_flow_api.g_varchar2_table(163) := '6164645F666175785F726F7773286C2D746869732E726F7773292C672626746869732E7365745F7769646765745F6D61785F73697A65286B2C67292C682626746869732E7365745F7769646765745F6D696E5F73697A65286B2C68292C746869732E7365';
wwv_flow_api.g_varchar2_table(164) := '745F646F6D5F677269645F776964746828292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E647261675F6170692E7365745F6C696D69747328746869732E636F6C732A746869732E6D696E5F7769646765745F776964';
wwv_flow_api.g_varchar2_table(165) := '74682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D292C746869732E6F7074696F6E732E63656E7465725F77696467657473262673657454696D656F757428612E70726F78792866756E';
wwv_flow_api.g_varchar2_table(166) := '6374696F6E28297B746869732E63656E7465725F7769646765747328297D2C74686973292C30292C746869732E6F7074696F6E732E73686F775F656C656D656E742E63616C6C28746869732C6B2C69292C6B7D2C682E7365745F7769646765745F6D696E';
wwv_flow_api.g_varchar2_table(167) := '5F73697A653D66756E6374696F6E28612C62297B696628613D226E756D626572223D3D747970656F6620613F746869732E24776964676574732E65712861293A612C21612E6C656E6774682972657475726E20746869733B76617220633D612E64617461';
wwv_flow_api.g_varchar2_table(168) := '2822636F6F72647322292E677269643B72657475726E20632E6D696E5F73697A655F783D625B305D2C632E6D696E5F73697A655F793D625B315D2C746869737D2C682E7365745F7769646765745F6D61785F73697A653D66756E6374696F6E28612C6229';
wwv_flow_api.g_varchar2_table(169) := '7B696628613D226E756D626572223D3D747970656F6620613F746869732E24776964676574732E65712861293A612C21612E6C656E6774682972657475726E20746869733B76617220633D612E646174612822636F6F72647322292E677269643B726574';
wwv_flow_api.g_varchar2_table(170) := '75726E20632E6D61785F73697A655F783D625B305D2C632E6D61785F73697A655F793D625B315D2C746869737D2C682E6164645F726573697A655F68616E646C653D66756E6374696F6E2862297B76617220633D746869732E6F7074696F6E732E726573';
wwv_flow_api.g_varchar2_table(171) := '697A652E68616E646C655F617070656E645F746F3F6128746869732E6F7074696F6E732E726573697A652E68616E646C655F617070656E645F746F2C62293A623B72657475726E20303D3D3D632E6368696C6472656E28227370616E5B636C6173737E3D';
wwv_flow_api.g_varchar2_table(172) := '27222B746869732E726573697A655F68616E646C655F636C6173732B22275D22292E6C656E67746826266128746869732E726573697A655F68616E646C655F74706C292E617070656E64546F2863292C746869737D2C682E726573697A655F7769646765';
wwv_flow_api.g_varchar2_table(173) := '743D66756E6374696F6E28612C622C632C64297B76617220653D612E636F6F72647328292E677269643B746869732E69735F726573697A696E673D21302C627C7C28623D652E73697A655F78292C637C7C28633D652E73697A655F79292C746869732E69';
wwv_flow_api.g_varchar2_table(174) := '735F76616C69645F726F7728652E726F772C63297C7C746869732E6164645F666175785F726F7773284D6174682E6D617828746869732E63616C63756C6174655F686967686573745F726F7728652E726F772C63292D746869732E726F77732C3029292C';
wwv_flow_api.g_varchar2_table(175) := '746869732E69735F76616C69645F636F6C28652E636F6C2C63297C7C746869732E6164645F666175785F636F6C73284D6174682E6D617828746869732E63616C63756C6174655F686967686573745F726F7728652E636F6C2C62292D746869732E636F6C';
wwv_flow_api.g_varchar2_table(176) := '732C3029293B76617220663D7B636F6C3A652E636F6C2C726F773A652E726F772C73697A655F783A622C73697A655F793A637D3B72657475726E20746869732E6D75746174655F7769646765745F696E5F677269646D617028612C652C66292C74686973';
wwv_flow_api.g_varchar2_table(177) := '2E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F776964746828292C642626642E63616C6C28746869732C662E73697A655F782C662E73697A655F79292C746869732E69735F726573697A696E673D';
wwv_flow_api.g_varchar2_table(178) := '21312C617D2C682E657870616E645F7769646765743D66756E6374696F6E28622C632C642C652C66297B76617220673D622E636F6F72647328292E677269642C683D4D6174682E666C6F6F722828612877696E646F77292E776964746828292D322A7468';
wwv_flow_api.g_varchar2_table(179) := '69732E6F7074696F6E732E7769646765745F6D617267696E735B305D292F746869732E6D696E5F7769646765745F7769647468293B633D637C7C4D6174682E6D696E28682C746869732E636F6C73292C647C7C28643D672E73697A655F79293B76617220';
wwv_flow_api.g_varchar2_table(180) := '693D672E73697A655F793B622E6174747228227072655F657870616E645F636F6C222C672E636F6C292C622E6174747228227072655F657870616E645F73697A6578222C672E73697A655F78292C622E6174747228227072655F657870616E645F73697A';
wwv_flow_api.g_varchar2_table(181) := '6579222C672E73697A655F79293B766172206A3D657C7C313B643E692626746869732E6164645F666175785F726F7773284D6174682E6D617828642D692C3029293B766172206B3D7B636F6C3A6A2C726F773A672E726F772C73697A655F783A632C7369';
wwv_flow_api.g_varchar2_table(182) := '7A655F793A647D3B72657475726E20746869732E6D75746174655F7769646765745F696E5F677269646D617028622C672C6B292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F776964';
wwv_flow_api.g_varchar2_table(183) := '746828292C662626662E63616C6C28746869732C6B2E73697A655F782C6B2E73697A655F79292C627D2C682E636F6C6C617073655F7769646765743D66756E6374696F6E28612C62297B76617220633D612E636F6F72647328292E677269642C643D7061';
wwv_flow_api.g_varchar2_table(184) := '727365496E7428612E6174747228227072655F657870616E645F73697A65782229292C653D7061727365496E7428612E6174747228227072655F657870616E645F73697A65792229292C663D7061727365496E7428612E6174747228227072655F657870';
wwv_flow_api.g_varchar2_table(185) := '616E645F636F6C2229292C673D7B636F6C3A662C726F773A632E726F772C73697A655F783A642C73697A655F793A657D3B72657475726E20746869732E6D75746174655F7769646765745F696E5F677269646D617028612C632C67292C746869732E7365';
wwv_flow_api.g_varchar2_table(186) := '745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F776964746828292C622626622E63616C6C28746869732C672E73697A655F782C672E73697A655F79292C617D2C682E6669745F746F5F636F6E74656E743D';
wwv_flow_api.g_varchar2_table(187) := '66756E6374696F6E28612C622C632C64297B76617220653D612E636F6F72647328292E677269642C663D746869732E24777261707065722E776964746828292C673D746869732E24777261707065722E68656967687428292C683D746869732E6F707469';
wwv_flow_api.g_varchar2_table(188) := '6F6E732E7769646765745F626173655F64696D656E73696F6E735B305D2B322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C693D746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E73';
wwv_flow_api.g_varchar2_table(189) := '5B315D2B322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D2C6A3D4D6174682E6365696C2828662B322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D292F68292C6B3D4D6174682E6365696C';
wwv_flow_api.g_varchar2_table(190) := '2828672B322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D292F69292C6C3D7B636F6C3A652E636F6C2C726F773A652E726F772C73697A655F783A4D6174682E6D696E28622C6A292C73697A655F793A4D6174682E6D696E';
wwv_flow_api.g_varchar2_table(191) := '28632C6B297D3B72657475726E20746869732E6D75746174655F7769646765745F696E5F677269646D617028612C652C6C292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F77696474';
wwv_flow_api.g_varchar2_table(192) := '6828292C642626642E63616C6C28746869732C6C2E73697A655F782C6C2E73697A655F79292C617D2C682E63656E7465725F776964676574733D6465626F756E63652866756E6374696F6E28297B76617220622C633D746869732E24777261707065722E';
wwv_flow_api.g_varchar2_table(193) := '776964746828293B623D746869732E69735F726573706F6E7369766528293F746869732E6765745F726573706F6E736976655F636F6C5F776964746828293A746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E735B30';
wwv_flow_api.g_varchar2_table(194) := '5D2B322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D3B76617220643D322A4D6174682E666C6F6F72284D6174682E6D6178284D6174682E666C6F6F7228632F62292C746869732E6D696E5F636F6C5F636F756E74292F32';
wwv_flow_api.g_varchar2_table(195) := '293B746869732E6F7074696F6E732E6D696E5F636F6C733D642C746869732E6F7074696F6E732E6D61785F636F6C733D642C746869732E6F7074696F6E732E65787472615F636F6C733D302C746869732E7365745F646F6D5F677269645F776964746828';
wwv_flow_api.g_varchar2_table(196) := '64292C746869732E636F6C733D643B76617220653D28642D746869732E707265765F636F6C5F636F756E74292F323B72657475726E20653C303F28746869732E6765745F6D696E5F636F6C28293E2D312A653F746869732E73686966745F636F6C732865';
wwv_flow_api.g_varchar2_table(197) := '293A746869732E726573697A655F7769646765745F64696D656E73696F6E7328746869732E6F7074696F6E73292C73657454696D656F757428612E70726F78792866756E6374696F6E28297B746869732E726573697A655F7769646765745F64696D656E';
wwv_flow_api.g_varchar2_table(198) := '73696F6E7328746869732E6F7074696F6E73297D2C74686973292C3029293A653E303F28746869732E726573697A655F7769646765745F64696D656E73696F6E7328746869732E6F7074696F6E73292C73657454696D656F757428612E70726F78792866';
wwv_flow_api.g_varchar2_table(199) := '756E6374696F6E28297B746869732E73686966745F636F6C732865297D2C74686973292C3029293A28746869732E726573697A655F7769646765745F64696D656E73696F6E7328746869732E6F7074696F6E73292C73657454696D656F757428612E7072';
wwv_flow_api.g_varchar2_table(200) := '6F78792866756E6374696F6E28297B746869732E726573697A655F7769646765745F64696D656E73696F6E7328746869732E6F7074696F6E73297D2C74686973292C3029292C746869732E707265765F636F6C5F636F756E743D642C746869737D2C3230';
wwv_flow_api.g_varchar2_table(201) := '30292C682E6765745F6D696E5F636F6C3D66756E6374696F6E28297B72657475726E204D6174682E6D696E2E6170706C79284D6174682C746869732E24776964676574732E6D617028612E70726F78792866756E6374696F6E28622C63297B7265747572';
wwv_flow_api.g_varchar2_table(202) := '6E20746869732E6765745F63656C6C735F6F6363757069656428612863292E636F6F72647328292E67726964292E636F6C737D2C7468697329292E6765742829297D2C682E73686966745F636F6C733D66756E6374696F6E2862297B76617220633D7468';
wwv_flow_api.g_varchar2_table(203) := '69732E24776964676574732E6D617028612E70726F78792866756E6374696F6E28622C63297B76617220643D612863293B72657475726E20746869732E646F6D5F746F5F636F6F7264732864297D2C7468697329293B633D642E736F72745F62795F726F';
wwv_flow_api.g_varchar2_table(204) := '775F616E645F636F6C5F6173632863292C632E6561636828612E70726F78792866756E6374696F6E28632C64297B76617220653D6128642E656C292C663D652E636F6F72647328292E677269642C673D7061727365496E7428652E617474722822646174';
wwv_flow_api.g_varchar2_table(205) := '612D636F6C2229292C683D7B636F6C3A4D6174682E6D6178284D6174682E726F756E6428672B62292C31292C726F773A662E726F772C73697A655F783A662E73697A655F782C73697A655F793A662E73697A655F797D3B73657454696D656F757428612E';
wwv_flow_api.g_varchar2_table(206) := '70726F78792866756E6374696F6E28297B746869732E6D75746174655F7769646765745F696E5F677269646D617028652C662C68297D2C74686973292C30297D2C7468697329297D2C682E6D75746174655F7769646765745F696E5F677269646D61703D';
wwv_flow_api.g_varchar2_table(207) := '66756E6374696F6E28622C632C64297B76617220653D632E73697A655F792C663D746869732E6765745F63656C6C735F6F636375706965642863292C673D746869732E6765745F63656C6C735F6F636375706965642864292C683D5B5D3B612E65616368';
wwv_flow_api.g_varchar2_table(208) := '28662E636F6C732C66756E6374696F6E28622C63297B2D313D3D3D612E696E417272617928632C672E636F6C73292626682E707573682863297D293B76617220693D5B5D3B612E6561636828672E636F6C732C66756E6374696F6E28622C63297B2D313D';
wwv_flow_api.g_varchar2_table(209) := '3D3D612E696E417272617928632C662E636F6C73292626692E707573682863297D293B766172206A3D5B5D3B612E6561636828662E726F77732C66756E6374696F6E28622C63297B2D313D3D3D612E696E417272617928632C672E726F77732926266A2E';
wwv_flow_api.g_varchar2_table(210) := '707573682863297D293B766172206B3D5B5D3B696628612E6561636828672E726F77732C66756E6374696F6E28622C63297B2D313D3D3D612E696E417272617928632C662E726F77732926266B2E707573682863297D292C746869732E72656D6F76655F';
wwv_flow_api.g_varchar2_table(211) := '66726F6D5F677269646D61702863292C692E6C656E677468297B766172206C3D5B642E636F6C2C642E726F772C642E73697A655F782C4D6174682E6D696E28652C642E73697A655F79292C625D3B746869732E656D7074795F63656C6C732E6170706C79';
wwv_flow_api.g_varchar2_table(212) := '28746869732C6C297D6966286B2E6C656E677468297B766172206D3D5B642E636F6C2C642E726F772C642E73697A655F782C642E73697A655F792C625D3B746869732E656D7074795F63656C6C732E6170706C7928746869732C6D297D696628632E636F';
wwv_flow_api.g_varchar2_table(213) := '6C3D642E636F6C2C632E726F773D642E726F772C632E73697A655F783D642E73697A655F782C632E73697A655F793D642E73697A655F792C746869732E6164645F746F5F677269646D617028642C62292C622E72656D6F7665436C6173732822706C6179';
wwv_flow_api.g_varchar2_table(214) := '65722D72657665727422292C746869732E7570646174655F7769646765745F64696D656E73696F6E7328622C64292C746869732E6F7074696F6E732E73686966745F776964676574735F7570297B696628682E6C656E677468297B766172206E3D5B685B';
wwv_flow_api.g_varchar2_table(215) := '305D2C642E726F772C685B682E6C656E6774682D315D2D685B305D2B312C4D6174682E6D696E28652C642E73697A655F79292C625D3B746869732E72656D6F76655F656D7074795F63656C6C732E6170706C7928746869732C6E297D6966286A2E6C656E';
wwv_flow_api.g_varchar2_table(216) := '677468297B766172206F3D5B642E636F6C2C642E726F772C642E73697A655F782C642E73697A655F792C625D3B746869732E72656D6F76655F656D7074795F63656C6C732E6170706C7928746869732C6F297D7D72657475726E20746869732E6D6F7665';
wwv_flow_api.g_varchar2_table(217) := '5F7769646765745F75702862292C746869737D2C682E656D7074795F63656C6C733D66756E6374696F6E28622C632C642C652C66297B72657475726E20746869732E776964676574735F62656C6F77287B636F6C3A622C726F773A632D652C73697A655F';
wwv_flow_api.g_varchar2_table(218) := '783A642C73697A655F793A657D292E6E6F742866292E6561636828612E70726F78792866756E6374696F6E28622C64297B76617220663D612864292C673D662E636F6F72647328292E677269643B696628672E726F773C3D632B652D31297B7661722068';
wwv_flow_api.g_varchar2_table(219) := '3D632B652D672E726F773B746869732E6D6F76655F7769646765745F646F776E28662C68297D7D2C7468697329292C746869732E69735F726573697A696E677C7C746869732E7365745F646F6D5F677269645F68656967687428292C746869737D2C682E';
wwv_flow_api.g_varchar2_table(220) := '72656D6F76655F656D7074795F63656C6C733D66756E6374696F6E28622C632C642C652C66297B72657475726E20746869732E776964676574735F62656C6F77287B636F6C3A622C726F773A632C73697A655F783A642C73697A655F793A657D292E6E6F';
wwv_flow_api.g_varchar2_table(221) := '742866292E6561636828612E70726F78792866756E6374696F6E28622C63297B746869732E6D6F76655F7769646765745F757028612863292C65297D2C7468697329292C746869732E7365745F646F6D5F677269645F68656967687428292C746869737D';
wwv_flow_api.g_varchar2_table(222) := '2C682E6E6578745F706F736974696F6E3D66756E6374696F6E28612C62297B617C7C28613D31292C627C7C28623D31293B666F722876617220632C653D746869732E677269646D61702C663D652E6C656E6774682C673D5B5D2C683D313B683C663B682B';
wwv_flow_api.g_varchar2_table(223) := '2B297B633D655B685D2E6C656E6774683B666F722876617220693D313B693C3D633B692B2B297B746869732E63616E5F6D6F76655F746F287B73697A655F783A612C73697A655F793A627D2C682C69292626672E70757368287B636F6C3A682C726F773A';
wwv_flow_api.g_varchar2_table(224) := '692C73697A655F793A622C73697A655F783A617D297D7D72657475726E2121672E6C656E6774682626642E736F72745F62795F726F775F616E645F636F6C5F6173632867295B305D7D2C682E72656D6F76655F62795F677269643D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(225) := '612C62297B76617220633D746869732E69735F77696467657428612C62293B632626746869732E72656D6F76655F7769646765742863297D2C682E72656D6F76655F7769646765743D66756E6374696F6E28622C632C64297B76617220653D6220696E73';
wwv_flow_api.g_varchar2_table(226) := '74616E63656F6620613F623A612862293B696628303D3D3D652E6C656E6774682972657475726E20746869733B76617220663D652E636F6F72647328292E677269643B696628766F696420303D3D3D662972657475726E20746869733B612E697346756E';
wwv_flow_api.g_varchar2_table(227) := '6374696F6E286329262628643D632C633D2131292C746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D7B7D2C746869732E24776964676574733D746869732E24776964676574732E6E6F742865293B76617220673D';
wwv_flow_api.g_varchar2_table(228) := '746869732E776964676574735F62656C6F772865293B72657475726E20746869732E72656D6F76655F66726F6D5F677269646D61702866292C746869732E6F7074696F6E732E686964655F656C656D656E742E63616C6C28746869732C652C612E70726F';
wwv_flow_api.g_varchar2_table(229) := '78792866756E6374696F6E28297B652E72656D6F766528292C637C7C672E6561636828612E70726F78792866756E6374696F6E28622C63297B746869732E6D6F76655F7769646765745F757028612863292C662E73697A655F79297D2C7468697329292C';
wwv_flow_api.g_varchar2_table(230) := '746869732E7365745F646F6D5F677269645F68656967687428292C642626642E63616C6C28746869732C62297D2C7468697329292C746869737D2C682E72656D6F76655F616C6C5F776964676574733D66756E6374696F6E2862297B72657475726E2074';
wwv_flow_api.g_varchar2_table(231) := '6869732E24776964676574732E6561636828612E70726F78792866756E6374696F6E28612C63297B746869732E72656D6F76655F77696467657428632C21302C62297D2C7468697329292C746869737D2C682E73657269616C697A653D66756E6374696F';
wwv_flow_api.g_varchar2_table(232) := '6E2862297B627C7C28623D746869732E2477696467657473293B76617220633D5B5D3B72657475726E20622E6561636828612E70726F78792866756E6374696F6E28622C64297B76617220653D612864293B766F69642030213D3D652E636F6F72647328';
wwv_flow_api.g_varchar2_table(233) := '292E677269642626632E7075736828746869732E6F7074696F6E732E73657269616C697A655F706172616D7328652C652E636F6F72647328292E6772696429297D2C7468697329292C637D2C682E73657269616C697A655F6368616E6765643D66756E63';
wwv_flow_api.g_varchar2_table(234) := '74696F6E28297B72657475726E20746869732E73657269616C697A6528746869732E246368616E676564297D2C682E646F6D5F746F5F636F6F7264733D66756E6374696F6E2861297B72657475726E7B636F6C3A7061727365496E7428612E6174747228';
wwv_flow_api.g_varchar2_table(235) := '22646174612D636F6C22292C3130292C726F773A7061727365496E7428612E617474722822646174612D726F7722292C3130292C73697A655F783A7061727365496E7428612E617474722822646174612D73697A657822292C3130297C7C312C73697A65';
wwv_flow_api.g_varchar2_table(236) := '5F793A7061727365496E7428612E617474722822646174612D73697A657922292C3130297C7C312C6D61785F73697A655F783A7061727365496E7428612E617474722822646174612D6D61782D73697A657822292C3130297C7C21312C6D61785F73697A';
wwv_flow_api.g_varchar2_table(237) := '655F793A7061727365496E7428612E617474722822646174612D6D61782D73697A657922292C3130297C7C21312C6D696E5F73697A655F783A7061727365496E7428612E617474722822646174612D6D696E2D73697A657822292C3130297C7C21312C6D';
wwv_flow_api.g_varchar2_table(238) := '696E5F73697A655F793A7061727365496E7428612E617474722822646174612D6D696E2D73697A657922292C3130297C7C21312C656C3A617D7D2C682E72656769737465725F7769646765743D66756E6374696F6E2862297B76617220633D6220696E73';
wwv_flow_api.g_varchar2_table(239) := '74616E63656F6620612C643D633F746869732E646F6D5F746F5F636F6F7264732862293A622C653D21313B637C7C28623D642E656C293B76617220663D746869732E63616E5F676F5F7769646765745F75702864293B72657475726E20746869732E6F70';
wwv_flow_api.g_varchar2_table(240) := '74696F6E732E73686966745F776964676574735F7570262666262628642E726F773D662C622E617474722822646174612D726F77222C66292C746869732E24656C2E74726967676572282267726964737465723A706F736974696F6E6368616E67656422';
wwv_flow_api.g_varchar2_table(241) := '2C5B645D292C653D2130292C746869732E6F7074696F6E732E61766F69645F6F7665726C61707065645F77696467657473262621746869732E63616E5F6D6F76655F746F287B73697A655F783A642E73697A655F782C73697A655F793A642E73697A655F';
wwv_flow_api.g_varchar2_table(242) := '797D2C642E636F6C2C642E726F7729262628612E657874656E6428642C746869732E6E6578745F706F736974696F6E28642E73697A655F782C642E73697A655F7929292C622E61747472287B22646174612D636F6C223A642E636F6C2C22646174612D72';
wwv_flow_api.g_varchar2_table(243) := '6F77223A642E726F772C22646174612D73697A6578223A642E73697A655F782C22646174612D73697A6579223A642E73697A655F797D292C653D2130292C622E646174612822636F6F726473222C622E636F6F7264732829292C622E646174612822636F';
wwv_flow_api.g_varchar2_table(244) := '6F72647322292E677269643D642C746869732E6164645F746F5F677269646D617028642C62292C746869732E7570646174655F7769646765745F64696D656E73696F6E7328622C64292C746869732E6F7074696F6E732E726573697A652E656E61626C65';
wwv_flow_api.g_varchar2_table(245) := '642626746869732E6164645F726573697A655F68616E646C652862292C657D2C682E7570646174655F7769646765745F706F736974696F6E3D66756E6374696F6E28612C62297B72657475726E20746869732E666F725F656163685F63656C6C5F6F6363';
wwv_flow_api.g_varchar2_table(246) := '757069656428612C66756E6374696F6E28612C63297B69662821746869732E677269646D61705B615D2972657475726E20746869733B746869732E677269646D61705B615D5B635D3D627D292C746869737D2C682E7570646174655F7769646765745F64';
wwv_flow_api.g_varchar2_table(247) := '696D656E73696F6E733D66756E6374696F6E28612C62297B76617220633D622E73697A655F782A28746869732E69735F726573706F6E7369766528293F746869732E6765745F726573706F6E736976655F636F6C5F776964746828293A746869732E6F70';
wwv_flow_api.g_varchar2_table(248) := '74696F6E732E7769646765745F626173655F64696D656E73696F6E735B305D292B28622E73697A655F782D31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C643D622E73697A655F792A746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(249) := '2E7769646765745F626173655F64696D656E73696F6E735B315D2B28622E73697A655F792D31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D3B72657475726E20612E646174612822636F6F72647322292E7570646174';
wwv_flow_api.g_varchar2_table(250) := '65287B77696474683A632C6865696768743A647D292C612E61747472287B22646174612D636F6C223A622E636F6C2C22646174612D726F77223A622E726F772C22646174612D73697A6578223A622E73697A655F782C22646174612D73697A6579223A62';
wwv_flow_api.g_varchar2_table(251) := '2E73697A655F797D292C746869737D2C682E7570646174655F776964676574735F64696D656E73696F6E733D66756E6374696F6E28297B72657475726E20612E6561636828746869732E24776964676574732C612E70726F78792866756E6374696F6E28';
wwv_flow_api.g_varchar2_table(252) := '622C63297B76617220643D612863292E636F6F72647328292E677269643B226F626A656374223D3D747970656F6620642626746869732E7570646174655F7769646765745F64696D656E73696F6E7328612863292C64297D2C7468697329292C74686973';
wwv_flow_api.g_varchar2_table(253) := '7D2C682E72656D6F76655F66726F6D5F677269646D61703D66756E6374696F6E2861297B72657475726E20746869732E7570646174655F7769646765745F706F736974696F6E28612C2131297D2C682E6164645F746F5F677269646D61703D66756E6374';
wwv_flow_api.g_varchar2_table(254) := '696F6E28612C62297B746869732E7570646174655F7769646765745F706F736974696F6E28612C627C7C612E656C297D2C682E647261676761626C653D66756E6374696F6E28297B76617220623D746869732C633D612E657874656E642821302C7B7D2C';
wwv_flow_api.g_varchar2_table(255) := '746869732E6F7074696F6E732E647261676761626C652C7B6F66667365745F6C6566743A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C6F66667365745F746F703A746869732E6F7074696F6E732E7769646765745F6D61';
wwv_flow_api.g_varchar2_table(256) := '7267696E735B315D2C636F6E7461696E65725F77696474683A746869732E636F6C732A746869732E6D696E5F7769646765745F77696474682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B30';
wwv_flow_api.g_varchar2_table(257) := '5D2C636F6E7461696E65725F6865696768743A746869732E726F77732A746869732E6D696E5F7769646765745F6865696768742B28746869732E726F77732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C6C696D';
wwv_flow_api.g_varchar2_table(258) := '69743A7B77696474683A746869732E6F7074696F6E732E6C696D69742E77696474682C6865696768743A746869732E6F7074696F6E732E6C696D69742E6865696768747D2C73746172743A66756E6374696F6E28632C64297B622E24776964676574732E';
wwv_flow_api.g_varchar2_table(259) := '66696C74657228222E706C617965722D72657665727422292E72656D6F7665436C6173732822706C617965722D72657665727422292C622E24706C617965723D612874686973292C622E2468656C7065723D6128642E2468656C706572292C622E68656C';
wwv_flow_api.g_varchar2_table(260) := '7065723D21622E2468656C7065722E697328622E24706C61796572292C622E6F6E5F73746172745F647261672E63616C6C28622C632C64292C622E24656C2E74726967676572282267726964737465723A64726167737461727422297D2C73746F703A66';
wwv_flow_api.g_varchar2_table(261) := '756E6374696F6E28612C63297B622E6F6E5F73746F705F647261672E63616C6C28622C612C63292C622E24656C2E74726967676572282267726964737465723A6472616773746F7022297D2C647261673A7468726F74746C652866756E6374696F6E2861';
wwv_flow_api.g_varchar2_table(262) := '2C63297B622E6F6E5F647261672E63616C6C28622C612C63292C622E24656C2E74726967676572282267726964737465723A6472616722297D2C3630297D293B746869732E647261675F6170693D746869732E24656C2E64726167672863292E64617461';
wwv_flow_api.g_varchar2_table(263) := '28226472616722297D2C682E726573697A61626C653D66756E6374696F6E28297B72657475726E20746869732E726573697A655F6170693D746869732E24656C2E67726964447261676761626C65287B6974656D733A222E222B746869732E6F7074696F';
wwv_flow_api.g_varchar2_table(264) := '6E732E726573697A652E68616E646C655F636C6173732C6F66667365745F6C6566743A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C636F6E7461696E65725F77696474683A746869732E636F6E7461696E65725F776964';
wwv_flow_api.g_varchar2_table(265) := '74682C6D6F76655F656C656D656E743A21312C726573697A653A21302C6C696D69743A7B77696474683A746869732E6F7074696F6E732E6D61785F636F6C73213D3D312F307C7C746869732E6F7074696F6E732E6C696D69742E77696474682C68656967';
wwv_flow_api.g_varchar2_table(266) := '68743A746869732E6F7074696F6E732E6D61785F726F7773213D3D312F307C7C746869732E6F7074696F6E732E6C696D69742E6865696768747D2C7363726F6C6C5F636F6E7461696E65723A746869732E6F7074696F6E732E7363726F6C6C5F636F6E74';
wwv_flow_api.g_varchar2_table(267) := '61696E65722C73746172743A612E70726F787928746869732E6F6E5F73746172745F726573697A652C74686973292C73746F703A612E70726F78792866756E6374696F6E28622C63297B64656C617928612E70726F78792866756E6374696F6E28297B74';
wwv_flow_api.g_varchar2_table(268) := '6869732E6F6E5F73746F705F726573697A6528622C63297D2C74686973292C313230297D2C74686973292C647261673A7468726F74746C6528612E70726F787928746869732E6F6E5F726573697A652C74686973292C3630297D292C746869737D2C682E';
wwv_flow_api.g_varchar2_table(269) := '73657475705F726573697A653D66756E6374696F6E28297B746869732E726573697A655F68616E646C655F636C6173733D746869732E6F7074696F6E732E726573697A652E68616E646C655F636C6173733B76617220623D746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(270) := '2E726573697A652E617865732C633D273C7370616E20636C6173733D22272B746869732E726573697A655F68616E646C655F636C6173732B2220222B746869732E726573697A655F68616E646C655F636C6173732B272D7B747970657D22202F3E273B72';
wwv_flow_api.g_varchar2_table(271) := '657475726E20746869732E726573697A655F68616E646C655F74706C3D612E6D617028622C66756E6374696F6E2861297B72657475726E20632E7265706C61636528227B747970657D222C61297D292E6A6F696E282222292C612E697341727261792874';
wwv_flow_api.g_varchar2_table(272) := '6869732E6F7074696F6E732E647261676761626C652E69676E6F72655F6472616767696E67292626746869732E6F7074696F6E732E647261676761626C652E69676E6F72655F6472616767696E672E7075736828222E222B746869732E726573697A655F';
wwv_flow_api.g_varchar2_table(273) := '68616E646C655F636C617373292C746869737D2C682E6F6E5F73746172745F647261673D66756E6374696F6E28622C63297B746869732E2468656C7065722E61646428746869732E24706C61796572292E61646428746869732E2477726170706572292E';
wwv_flow_api.g_varchar2_table(274) := '616464436C61737328226472616767696E6722292C746869732E686967686573745F636F6C3D746869732E6765745F686967686573745F6F636375706965645F63656C6C28292E636F6C2C746869732E24706C617965722E616464436C6173732822706C';
wwv_flow_api.g_varchar2_table(275) := '6179657222292C746869732E706C617965725F677269645F646174613D746869732E24706C617965722E636F6F72647328292E677269642C746869732E706C616365686F6C6465725F677269645F646174613D612E657874656E64287B7D2C746869732E';
wwv_flow_api.g_varchar2_table(276) := '706C617965725F677269645F64617461292C746869732E6765745F686967686573745F6F636375706965645F63656C6C28292E726F772B746869732E706C617965725F677269645F646174612E73697A655F793C3D746869732E6F7074696F6E732E6D61';
wwv_flow_api.g_varchar2_table(277) := '785F726F77732626746869732E7365745F646F6D5F677269645F68656967687428746869732E24656C2E68656967687428292B746869732E706C617965725F677269645F646174612E73697A655F792A746869732E6D696E5F7769646765745F68656967';
wwv_flow_api.g_varchar2_table(278) := '6874292C746869732E7365745F646F6D5F677269645F776964746828746869732E636F6C73293B76617220643D746869732E706C617965725F677269645F646174612E73697A655F782C653D746869732E636F6C732D746869732E686967686573745F63';
wwv_flow_api.g_varchar2_table(279) := '6F6C3B746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F302626653C3D642626746869732E6164645F666175785F636F6C73284D6174682E6D696E28642D652C3129293B76617220663D746869732E666175785F677269642C673D746869';
wwv_flow_api.g_varchar2_table(280) := '732E24706C617965722E646174612822636F6F72647322292E636F6F7264733B746869732E63656C6C735F6F636375706965645F62795F706C617965723D746869732E6765745F63656C6C735F6F6363757069656428746869732E706C617965725F6772';
wwv_flow_api.g_varchar2_table(281) := '69645F64617461292C746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D746869732E6765745F63656C6C735F6F6363757069656428746869732E706C616365686F6C6465725F677269645F64617461292C74686973';
wwv_flow_api.g_varchar2_table(282) := '2E6C6173745F636F6C733D5B5D2C746869732E6C6173745F726F77733D5B5D2C746869732E636F6C6C6973696F6E5F6170693D746869732E2468656C7065722E636F6C6C6973696F6E28662C746869732E6F7074696F6E732E636F6C6C6973696F6E292C';
wwv_flow_api.g_varchar2_table(283) := '746869732E24707265766965775F686F6C6465723D6128223C222B746869732E24706C617965722E6765742830292E7461674E616D652B22202F3E222C7B636C6173733A22707265766965772D686F6C646572222C22646174612D726F77223A74686973';
wwv_flow_api.g_varchar2_table(284) := '2E24706C617965722E617474722822646174612D726F7722292C22646174612D636F6C223A746869732E24706C617965722E617474722822646174612D636F6C22292C6373733A7B77696474683A672E77696474682C6865696768743A672E6865696768';
wwv_flow_api.g_varchar2_table(285) := '747D7D292E617070656E64546F28746869732E24656C292C746869732E6F7074696F6E732E647261676761626C652E73746172742626746869732E6F7074696F6E732E647261676761626C652E73746172742E63616C6C28746869732C622C63297D2C68';
wwv_flow_api.g_varchar2_table(286) := '2E6F6E5F647261673D66756E6374696F6E28612C62297B6966286E756C6C3D3D3D746869732E24706C617965722972657475726E21313B76617220633D746869732E6F7074696F6E732E7769646765745F6D617267696E732C643D746869732E24707265';
wwv_flow_api.g_varchar2_table(287) := '766965775F686F6C6465722E617474722822646174612D636F6C22292C653D746869732E24707265766965775F686F6C6465722E617474722822646174612D726F7722292C663D7B6C6566743A622E706F736974696F6E2E6C6566742B746869732E6261';
wwv_flow_api.g_varchar2_table(288) := '7365582D635B305D2A642C746F703A622E706F736974696F6E2E746F702B746869732E62617365592D635B315D2A657D3B696628746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F30297B746869732E706C616365686F6C6465725F6772';
wwv_flow_api.g_varchar2_table(289) := '69645F646174612E636F6C2B746869732E706C616365686F6C6465725F677269645F646174612E73697A655F782D313E3D746869732E636F6C732D312626746869732E6F7074696F6E732E6D61785F636F6C733E3D746869732E636F6C732B3126262874';
wwv_flow_api.g_varchar2_table(290) := '6869732E6164645F666175785F636F6C732831292C746869732E7365745F646F6D5F677269645F776964746828746869732E636F6C732B31292C746869732E647261675F6170692E7365745F6C696D69747328746869732E636F6C732A746869732E6D69';
wwv_flow_api.g_varchar2_table(291) := '6E5F7769646765745F77696474682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D29292C746869732E636F6C6C6973696F6E5F6170692E7365745F636F6C6C696465727328746869732E';
wwv_flow_api.g_varchar2_table(292) := '666175785F67726964297D746869732E636F6C6C69646572735F646174613D746869732E636F6C6C6973696F6E5F6170692E6765745F636C6F736573745F636F6C6C69646572732866292C746869732E6F6E5F6F7665726C61707065645F636F6C756D6E';
wwv_flow_api.g_varchar2_table(293) := '5F6368616E676528746869732E6F6E5F73746172745F6F7665726C617070696E675F636F6C756D6E2C746869732E6F6E5F73746F705F6F7665726C617070696E675F636F6C756D6E292C746869732E6F6E5F6F7665726C61707065645F726F775F636861';
wwv_flow_api.g_varchar2_table(294) := '6E676528746869732E6F6E5F73746172745F6F7665726C617070696E675F726F772C746869732E6F6E5F73746F705F6F7665726C617070696E675F726F77292C746869732E68656C7065722626746869732E24706C617965722626746869732E24706C61';
wwv_flow_api.g_varchar2_table(295) := '7965722E637373287B6C6566743A622E706F736974696F6E2E6C6566742C746F703A622E706F736974696F6E2E746F707D292C746869732E6F7074696F6E732E647261676761626C652E647261672626746869732E6F7074696F6E732E64726167676162';
wwv_flow_api.g_varchar2_table(296) := '6C652E647261672E63616C6C28746869732C612C62297D2C682E6F6E5F73746F705F647261673D66756E6374696F6E28612C62297B746869732E2468656C7065722E61646428746869732E24706C61796572292E61646428746869732E24777261707065';
wwv_flow_api.g_varchar2_table(297) := '72292E72656D6F7665436C61737328226472616767696E6722293B76617220633D746869732E6F7074696F6E732E7769646765745F6D617267696E732C643D746869732E24707265766965775F686F6C6465722E617474722822646174612D636F6C2229';
wwv_flow_api.g_varchar2_table(298) := '2C653D746869732E24707265766965775F686F6C6465722E617474722822646174612D726F7722293B622E706F736974696F6E2E6C6566743D622E706F736974696F6E2E6C6566742B746869732E62617365582D635B305D2A642C622E706F736974696F';
wwv_flow_api.g_varchar2_table(299) := '6E2E746F703D622E706F736974696F6E2E746F702B746869732E62617365592D635B315D2A652C746869732E636F6C6C69646572735F646174613D746869732E636F6C6C6973696F6E5F6170692E6765745F636C6F736573745F636F6C6C696465727328';
wwv_flow_api.g_varchar2_table(300) := '622E706F736974696F6E292C746869732E6F6E5F6F7665726C61707065645F636F6C756D6E5F6368616E676528746869732E6F6E5F73746172745F6F7665726C617070696E675F636F6C756D6E2C746869732E6F6E5F73746F705F6F7665726C61707069';
wwv_flow_api.g_varchar2_table(301) := '6E675F636F6C756D6E292C746869732E6F6E5F6F7665726C61707065645F726F775F6368616E676528746869732E6F6E5F73746172745F6F7665726C617070696E675F726F772C746869732E6F6E5F73746F705F6F7665726C617070696E675F726F7729';
wwv_flow_api.g_varchar2_table(302) := '2C746869732E246368616E6765643D746869732E246368616E6765642E61646428746869732E24706C61796572293B76617220663D746869732E706C616365686F6C6465725F677269645F646174612E656C2E636F6F72647328292E677269643B662E63';
wwv_flow_api.g_varchar2_table(303) := '6F6C3D3D3D746869732E706C616365686F6C6465725F677269645F646174612E636F6C2626662E726F773D3D3D746869732E706C616365686F6C6465725F677269645F646174612E726F777C7C28746869732E7570646174655F7769646765745F706F73';
wwv_flow_api.g_varchar2_table(304) := '6974696F6E28662C2131292C746869732E6F7074696F6E732E636F6C6C6973696F6E2E776169745F666F725F6D6F75736575702626746869732E666F725F656163685F63656C6C5F6F6363757069656428746869732E706C616365686F6C6465725F6772';
wwv_flow_api.g_varchar2_table(305) := '69645F646174612C66756E6374696F6E28612C62297B696628746869732E69735F77696467657428612C6229297B76617220633D746869732E706C616365686F6C6465725F677269645F646174612E726F772B746869732E706C616365686F6C6465725F';
wwv_flow_api.g_varchar2_table(306) := '677269645F646174612E73697A655F792C643D7061727365496E7428746869732E677269646D61705B615D5B625D5B305D2E6765744174747269627574652822646174612D726F772229292C653D632D643B21746869732E6D6F76655F7769646765745F';
wwv_flow_api.g_varchar2_table(307) := '646F776E28746869732E69735F77696467657428612C62292C65292626746869732E7365745F706C616365686F6C64657228746869732E706C616365686F6C6465725F677269645F646174612E656C2E636F6F72647328292E677269642E636F6C2C7468';
wwv_flow_api.g_varchar2_table(308) := '69732E706C616365686F6C6465725F677269645F646174612E656C2E636F6F72647328292E677269642E726F77297D7D29292C746869732E63656C6C735F6F636375706965645F62795F706C617965723D746869732E6765745F63656C6C735F6F636375';
wwv_flow_api.g_varchar2_table(309) := '7069656428746869732E706C616365686F6C6465725F677269645F64617461293B76617220673D746869732E706C616365686F6C6465725F677269645F646174612E636F6C2C683D746869732E706C616365686F6C6465725F677269645F646174612E72';
wwv_flow_api.g_varchar2_table(310) := '6F773B746869732E7365745F63656C6C735F706C617965725F6F6363757069657328672C68292C746869732E24706C617965722E636F6F72647328292E677269642E726F773D682C746869732E24706C617965722E636F6F72647328292E677269642E63';
wwv_flow_api.g_varchar2_table(311) := '6F6C3D672C746869732E24706C617965722E616464436C6173732822706C617965722D72657665727422292E72656D6F7665436C6173732822706C6179657222292E61747472287B22646174612D636F6C223A672C22646174612D726F77223A687D292E';
wwv_flow_api.g_varchar2_table(312) := '637373287B6C6566743A22222C746F703A22227D292C746869732E6F7074696F6E732E647261676761626C652E73746F702626746869732E6F7074696F6E732E647261676761626C652E73746F702E63616C6C28746869732C612C62292C746869732E24';
wwv_flow_api.g_varchar2_table(313) := '707265766965775F686F6C6465722E72656D6F766528292C746869732E24706C617965723D6E756C6C2C746869732E2468656C7065723D6E756C6C2C746869732E706C616365686F6C6465725F677269645F646174613D7B7D2C746869732E706C617965';
wwv_flow_api.g_varchar2_table(314) := '725F677269645F646174613D7B7D2C746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D7B7D2C746869732E63656C6C735F6F636375706965645F62795F706C617965723D7B7D2C746869732E775F71756575653D7B';
wwv_flow_api.g_varchar2_table(315) := '7D2C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F776964746828292C746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F302626746869732E647261675F6170692E7365';
wwv_flow_api.g_varchar2_table(316) := '745F6C696D69747328746869732E636F6C732A746869732E6D696E5F7769646765745F77696474682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D297D2C682E6F6E5F73746172745F72';
wwv_flow_api.g_varchar2_table(317) := '6573697A653D66756E6374696F6E28622C63297B746869732E24726573697A65645F7769646765743D632E24706C617965722E636C6F7365737428222E67732D7722292C746869732E726573697A655F636F6F7264733D746869732E24726573697A6564';
wwv_flow_api.g_varchar2_table(318) := '5F7769646765742E636F6F72647328292C746869732E726573697A655F7767643D746869732E726573697A655F636F6F7264732E677269642C746869732E726573697A655F696E697469616C5F77696474683D746869732E726573697A655F636F6F7264';
wwv_flow_api.g_varchar2_table(319) := '732E636F6F7264732E77696474682C746869732E726573697A655F696E697469616C5F6865696768743D746869732E726573697A655F636F6F7264732E636F6F7264732E6865696768742C746869732E726573697A655F696E697469616C5F73697A6578';
wwv_flow_api.g_varchar2_table(320) := '3D746869732E726573697A655F636F6F7264732E677269642E73697A655F782C746869732E726573697A655F696E697469616C5F73697A65793D746869732E726573697A655F636F6F7264732E677269642E73697A655F792C746869732E726573697A65';
wwv_flow_api.g_varchar2_table(321) := '5F696E697469616C5F636F6C3D746869732E726573697A655F636F6F7264732E677269642E636F6C2C746869732E726573697A655F6C6173745F73697A65783D746869732E726573697A655F696E697469616C5F73697A65782C0A746869732E72657369';
wwv_flow_api.g_varchar2_table(322) := '7A655F6C6173745F73697A65793D746869732E726573697A655F696E697469616C5F73697A65792C746869732E726573697A655F6D61785F73697A655F783D4D6174682E6D696E28746869732E726573697A655F7767642E6D61785F73697A655F787C7C';
wwv_flow_api.g_varchar2_table(323) := '746869732E6F7074696F6E732E726573697A652E6D61785F73697A655B305D2C746869732E6F7074696F6E732E6D61785F636F6C732D746869732E726573697A655F696E697469616C5F636F6C2B31292C746869732E726573697A655F6D61785F73697A';
wwv_flow_api.g_varchar2_table(324) := '655F793D746869732E726573697A655F7767642E6D61785F73697A655F797C7C746869732E6F7074696F6E732E726573697A652E6D61785F73697A655B315D2C746869732E726573697A655F6D696E5F73697A655F783D746869732E726573697A655F77';
wwv_flow_api.g_varchar2_table(325) := '67642E6D696E5F73697A655F787C7C746869732E6F7074696F6E732E726573697A652E6D696E5F73697A655B305D7C7C312C746869732E726573697A655F6D696E5F73697A655F793D746869732E726573697A655F7767642E6D696E5F73697A655F797C';
wwv_flow_api.g_varchar2_table(326) := '7C746869732E6F7074696F6E732E726573697A652E6D696E5F73697A655B315D7C7C312C746869732E726573697A655F696E697469616C5F6C6173745F636F6C3D746869732E6765745F686967686573745F6F636375706965645F63656C6C28292E636F';
wwv_flow_api.g_varchar2_table(327) := '6C2C746869732E7365745F646F6D5F677269645F776964746828746869732E636F6C73292C746869732E726573697A655F6469723D7B72696768743A632E24706C617965722E697328222E222B746869732E726573697A655F68616E646C655F636C6173';
wwv_flow_api.g_varchar2_table(328) := '732B222D7822292C626F74746F6D3A632E24706C617965722E697328222E222B746869732E726573697A655F68616E646C655F636C6173732B222D7922297D2C746869732E69735F726573706F6E7369766528297C7C746869732E24726573697A65645F';
wwv_flow_api.g_varchar2_table(329) := '7769646765742E637373287B226D696E2D7769647468223A746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E735B305D2C226D696E2D686569676874223A746869732E6F7074696F6E732E7769646765745F62617365';
wwv_flow_api.g_varchar2_table(330) := '5F64696D656E73696F6E735B315D7D293B76617220643D746869732E24726573697A65645F7769646765742E6765742830292E7461674E616D653B746869732E24726573697A655F707265766965775F686F6C6465723D6128223C222B642B22202F3E22';
wwv_flow_api.g_varchar2_table(331) := '2C7B636C6173733A22707265766965772D686F6C64657220726573697A652D707265766965772D686F6C646572222C22646174612D726F77223A746869732E24726573697A65645F7769646765742E617474722822646174612D726F7722292C22646174';
wwv_flow_api.g_varchar2_table(332) := '612D636F6C223A746869732E24726573697A65645F7769646765742E617474722822646174612D636F6C22292C6373733A7B77696474683A746869732E726573697A655F696E697469616C5F77696474682C6865696768743A746869732E726573697A65';
wwv_flow_api.g_varchar2_table(333) := '5F696E697469616C5F6865696768747D7D292E617070656E64546F28746869732E24656C292C746869732E24726573697A65645F7769646765742E616464436C6173732822726573697A696E6722292C746869732E6F7074696F6E732E726573697A652E';
wwv_flow_api.g_varchar2_table(334) := '73746172742626746869732E6F7074696F6E732E726573697A652E73746172742E63616C6C28746869732C622C632C746869732E24726573697A65645F776964676574292C746869732E24656C2E74726967676572282267726964737465723A72657369';
wwv_flow_api.g_varchar2_table(335) := '7A65737461727422297D2C682E6F6E5F73746F705F726573697A653D66756E6374696F6E28622C63297B746869732E24726573697A65645F7769646765742E72656D6F7665436C6173732822726573697A696E6722292E637373287B77696474683A2222';
wwv_flow_api.g_varchar2_table(336) := '2C6865696768743A22222C226D696E2D7769647468223A22222C226D696E2D686569676874223A22227D292C64656C617928612E70726F78792866756E6374696F6E28297B746869732E24726573697A655F707265766965775F686F6C6465722E72656D';
wwv_flow_api.g_varchar2_table(337) := '6F766528292E637373287B226D696E2D7769647468223A22222C226D696E2D686569676874223A22227D292C746869732E6F7074696F6E732E726573697A652E73746F702626746869732E6F7074696F6E732E726573697A652E73746F702E63616C6C28';
wwv_flow_api.g_varchar2_table(338) := '746869732C622C632C746869732E24726573697A65645F776964676574292C746869732E24656C2E74726967676572282267726964737465723A726573697A6573746F7022297D2C74686973292C333030292C746869732E7365745F646F6D5F67726964';
wwv_flow_api.g_varchar2_table(339) := '5F776964746828292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F302626746869732E647261675F6170692E7365745F6C696D69747328746869732E636F6C732A';
wwv_flow_api.g_varchar2_table(340) := '746869732E6D696E5F7769646765745F7769647468297D2C682E6F6E5F726573697A653D66756E6374696F6E28612C62297B76617220632C643D622E706F696E7465722E646966665F6C6566742C653D622E706F696E7465722E646966665F746F702C66';
wwv_flow_api.g_varchar2_table(341) := '3D746869732E69735F726573706F6E7369766528293F746869732E6765745F726573706F6E736976655F636F6C5F776964746828293A746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E735B305D2C673D746869732E';
wwv_flow_api.g_varchar2_table(342) := '6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E735B315D2C683D746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2C693D746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D2C';
wwv_flow_api.g_varchar2_table(343) := '6A3D746869732E726573697A655F6D61785F73697A655F782C6B3D746869732E726573697A655F6D696E5F73697A655F782C6C3D746869732E726573697A655F6D61785F73697A655F792C6D3D746869732E726573697A655F6D696E5F73697A655F792C';
wwv_flow_api.g_varchar2_table(344) := '6E3D746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F302C6F3D4D6174682E6365696C28642F28662B322A68292D2E32292C703D4D6174682E6365696C28652F28672B322A69292D2E32292C713D4D6174682E6D617828312C746869732E';
wwv_flow_api.g_varchar2_table(345) := '726573697A655F696E697469616C5F73697A65782B6F292C723D4D6174682E6D617828312C746869732E726573697A655F696E697469616C5F73697A65792B70292C733D4D6174682E666C6F6F7228746869732E636F6E7461696E65725F77696474682F';
wwv_flow_api.g_varchar2_table(346) := '746869732E6D696E5F7769646765745F77696474682D746869732E726573697A655F696E697469616C5F636F6C2B31292C743D732A746869732E6D696E5F7769646765745F77696474682B28732D31292A683B713D4D6174682E6D6178284D6174682E6D';
wwv_flow_api.g_varchar2_table(347) := '696E28712C6A292C6B292C713D4D6174682E6D696E28732C71292C633D6A2A662B28712D31292A683B76617220753D4D6174682E6D696E28632C74292C763D6B2A662B28712D31292A683B723D4D6174682E6D6178284D6174682E6D696E28722C6C292C';
wwv_flow_api.g_varchar2_table(348) := '6D293B76617220773D6C2A672B28722D31292A692C783D6D2A672B28722D31292A693B696628746869732E726573697A655F6469722E72696768743F723D746869732E726573697A655F696E697469616C5F73697A65793A746869732E726573697A655F';
wwv_flow_api.g_varchar2_table(349) := '6469722E626F74746F6D262628713D746869732E726573697A655F696E697469616C5F73697A6578292C6E297B76617220793D746869732E726573697A655F696E697469616C5F636F6C2B712D313B6E2626746869732E726573697A655F696E69746961';
wwv_flow_api.g_varchar2_table(350) := '6C5F6C6173745F636F6C3C3D79262628746869732E7365745F646F6D5F677269645F7769647468284D6174682E6D617828792B312C746869732E636F6C7329292C746869732E636F6C733C792626746869732E6164645F666175785F636F6C7328792D74';
wwv_flow_api.g_varchar2_table(351) := '6869732E636F6C7329297D766172207A3D7B7D3B21746869732E726573697A655F6469722E626F74746F6D2626287A2E77696474683D4D6174682E6D6178284D6174682E6D696E28746869732E726573697A655F696E697469616C5F77696474682B642C';
wwv_flow_api.g_varchar2_table(352) := '75292C7629292C21746869732E726573697A655F6469722E72696768742626287A2E6865696768743D4D6174682E6D6178284D6174682E6D696E28746869732E726573697A655F696E697469616C5F6865696768742B652C77292C7829292C746869732E';
wwv_flow_api.g_varchar2_table(353) := '24726573697A65645F7769646765742E637373287A292C713D3D3D746869732E726573697A655F6C6173745F73697A65782626723D3D3D746869732E726573697A655F6C6173745F73697A65797C7C28746869732E726573697A655F7769646765742874';
wwv_flow_api.g_varchar2_table(354) := '6869732E24726573697A65645F7769646765742C712C722C2131292C746869732E7365745F646F6D5F677269645F776964746828746869732E636F6C73292C746869732E24726573697A655F707265766965775F686F6C6465722E637373287B77696474';
wwv_flow_api.g_varchar2_table(355) := '683A22222C6865696768743A22227D292E61747472287B22646174612D726F77223A746869732E24726573697A65645F7769646765742E617474722822646174612D726F7722292C22646174612D73697A6578223A712C22646174612D73697A6579223A';
wwv_flow_api.g_varchar2_table(356) := '727D29292C746869732E6F7074696F6E732E726573697A652E726573697A652626746869732E6F7074696F6E732E726573697A652E726573697A652E63616C6C28746869732C612C622C746869732E24726573697A65645F776964676574292C74686973';
wwv_flow_api.g_varchar2_table(357) := '2E24656C2E74726967676572282267726964737465723A726573697A6522292C746869732E726573697A655F6C6173745F73697A65783D712C746869732E726573697A655F6C6173745F73697A65793D727D2C682E6F6E5F6F7665726C61707065645F63';
wwv_flow_api.g_varchar2_table(358) := '6F6C756D6E5F6368616E67653D66756E6374696F6E28622C63297B69662821746869732E636F6C6C69646572735F646174612E6C656E6774682972657475726E20746869733B76617220642C653D746869732E6765745F74617267657465645F636F6C75';
wwv_flow_api.g_varchar2_table(359) := '6D6E7328746869732E636F6C6C69646572735F646174615B305D2E656C2E646174612E636F6C292C663D746869732E6C6173745F636F6C732E6C656E6774682C673D652E6C656E6774683B666F7228643D303B643C673B642B2B292D313D3D3D612E696E';
wwv_flow_api.g_varchar2_table(360) := '417272617928655B645D2C746869732E6C6173745F636F6C7329262628627C7C612E6E6F6F70292E63616C6C28746869732C655B645D293B666F7228643D303B643C663B642B2B292D313D3D3D612E696E417272617928746869732E6C6173745F636F6C';
wwv_flow_api.g_varchar2_table(361) := '735B645D2C6529262628637C7C612E6E6F6F70292E63616C6C28746869732C746869732E6C6173745F636F6C735B645D293B72657475726E20746869732E6C6173745F636F6C733D652C746869737D2C682E6F6E5F6F7665726C61707065645F726F775F';
wwv_flow_api.g_varchar2_table(362) := '6368616E67653D66756E6374696F6E28622C63297B69662821746869732E636F6C6C69646572735F646174612E6C656E6774682972657475726E20746869733B76617220642C653D746869732E6765745F74617267657465645F726F777328746869732E';
wwv_flow_api.g_varchar2_table(363) := '636F6C6C69646572735F646174615B305D2E656C2E646174612E726F77292C663D746869732E6C6173745F726F77732E6C656E6774682C673D652E6C656E6774683B666F7228643D303B643C673B642B2B292D313D3D3D612E696E417272617928655B64';
wwv_flow_api.g_varchar2_table(364) := '5D2C746869732E6C6173745F726F777329262628627C7C612E6E6F6F70292E63616C6C28746869732C655B645D293B666F7228643D303B643C663B642B2B292D313D3D3D612E696E417272617928746869732E6C6173745F726F77735B645D2C65292626';
wwv_flow_api.g_varchar2_table(365) := '28637C7C612E6E6F6F70292E63616C6C28746869732C746869732E6C6173745F726F77735B645D293B746869732E6C6173745F726F77733D657D2C682E7365745F706C617965723D66756E6374696F6E28622C632C64297B76617220653D746869732C66';
wwv_flow_api.g_varchar2_table(366) := '3D21312C673D643F7B636F6C3A627D3A652E636F6C6C69646572735F646174615B305D2E656C2E646174612C683D672E636F6C2C693D672E726F777C7C633B746869732E706C617965725F677269645F646174613D7B636F6C3A682C726F773A692C7369';
wwv_flow_api.g_varchar2_table(367) := '7A655F793A746869732E706C617965725F677269645F646174612E73697A655F792C73697A655F783A746869732E706C617965725F677269645F646174612E73697A655F787D2C746869732E63656C6C735F6F636375706965645F62795F706C61796572';
wwv_flow_api.g_varchar2_table(368) := '3D746869732E6765745F63656C6C735F6F6363757069656428746869732E706C617965725F677269645F64617461292C746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D746869732E6765745F63656C6C735F6F63';
wwv_flow_api.g_varchar2_table(369) := '63757069656428746869732E706C616365686F6C6465725F677269645F64617461293B766172206A3D746869732E6765745F776964676574735F6F7665726C617070656428746869732E706C617965725F677269645F64617461292C6B3D746869732E70';
wwv_flow_api.g_varchar2_table(370) := '6C617965725F677269645F646174612E73697A655F792C6C3D746869732E706C617965725F677269645F646174612E73697A655F782C6D3D746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465722C6E3D746869733B6966';
wwv_flow_api.g_varchar2_table(371) := '286A2E6561636828612E70726F78792866756E6374696F6E28622C63297B76617220643D612863292C653D642E636F6F72647328292E677269642C673D6D2E636F6C735B305D2B6C2D312C6F3D6D2E726F77735B305D2B6B2D313B696628642E68617343';
wwv_flow_api.g_varchar2_table(372) := '6C617373286E2E6F7074696F6E732E7374617469635F636C617373292972657475726E21303B6966286E2E6F7074696F6E732E636F6C6C6973696F6E2E776169745F666F725F6D6F757365757026266E2E647261675F6170692E69735F6472616767696E';
wwv_flow_api.g_varchar2_table(373) := '67296E2E706C616365686F6C6465725F677269645F646174612E636F6C3D682C6E2E706C616365686F6C6465725F677269645F646174612E726F773D692C6E2E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D6E2E6765745F';
wwv_flow_api.g_varchar2_table(374) := '63656C6C735F6F63637570696564286E2E706C616365686F6C6465725F677269645F64617461292C6E2E24707265766965775F686F6C6465722E61747472287B22646174612D726F77223A692C22646174612D636F6C223A687D293B656C736520696628';
wwv_flow_api.g_varchar2_table(375) := '652E73697A655F783C3D6C2626652E73697A655F793C3D6B296966286E2E69735F737761705F6F63637570696564286D2E636F6C735B305D2C652E726F772C652E73697A655F782C652E73697A655F79297C7C6E2E69735F706C617965725F696E286D2E';
wwv_flow_api.g_varchar2_table(376) := '636F6C735B305D2C652E726F77297C7C6E2E69735F696E5F7175657565286D2E636F6C735B305D2C652E726F772C6429296966286E2E69735F737761705F6F6363757069656428672C652E726F772C652E73697A655F782C652E73697A655F79297C7C6E';
wwv_flow_api.g_varchar2_table(377) := '2E69735F706C617965725F696E28672C652E726F77297C7C6E2E69735F696E5F717565756528672C652E726F772C6429296966286E2E69735F737761705F6F6363757069656428652E636F6C2C6D2E726F77735B305D2C652E73697A655F782C652E7369';
wwv_flow_api.g_varchar2_table(378) := '7A655F79297C7C6E2E69735F706C617965725F696E28652E636F6C2C6D2E726F77735B305D297C7C6E2E69735F696E5F717565756528652E636F6C2C6D2E726F77735B305D2C6429296966286E2E69735F737761705F6F6363757069656428652E636F6C';
wwv_flow_api.g_varchar2_table(379) := '2C6F2C652E73697A655F782C652E73697A655F79297C7C6E2E69735F706C617965725F696E28652E636F6C2C6F297C7C6E2E69735F696E5F717565756528652E636F6C2C6F2C6429296966286E2E69735F737761705F6F63637570696564286D2E636F6C';
wwv_flow_api.g_varchar2_table(380) := '735B305D2C6D2E726F77735B305D2C652E73697A655F782C652E73697A655F79297C7C6E2E69735F706C617965725F696E286D2E636F6C735B305D2C6D2E726F77735B305D297C7C6E2E69735F696E5F7175657565286D2E636F6C735B305D2C6D2E726F';
wwv_flow_api.g_varchar2_table(381) := '77735B305D2C642929666F722876617220703D303B703C6C3B702B2B29666F722876617220713D303B713C6B3B712B2B297B76617220723D6D2E636F6C735B305D2B702C733D6D2E726F77735B305D2B713B696628216E2E69735F737761705F6F636375';
wwv_flow_api.g_varchar2_table(382) := '7069656428722C732C652E73697A655F782C652E73697A655F79292626216E2E69735F706C617965725F696E28722C73292626216E2E69735F696E5F717565756528722C732C6429297B663D6E2E71756575655F77696467657428722C732C64292C703D';
wwv_flow_api.g_varchar2_table(383) := '6C3B627265616B7D7D656C7365206E2E6F7074696F6E732E6D6F76655F776964676574735F646F776E5F6F6E6C793F6A2E6561636828612E70726F78792866756E6374696F6E28622C63297B76617220643D612863293B6E2E63616E5F676F5F646F776E';
wwv_flow_api.g_varchar2_table(384) := '2864292626642E636F6F72647328292E677269642E726F773D3D3D6E2E706C617965725F677269645F646174612E726F772626216E2E69735F696E5F717565756528672C652E726F772C64292626286E2E6D6F76655F7769646765745F646F776E28642C';
wwv_flow_api.g_varchar2_table(385) := '6E2E706C617965725F677269645F646174612E73697A655F79292C6E2E7365745F706C616365686F6C64657228682C6929297D29293A663D6E2E71756575655F776964676574286D2E636F6C735B305D2C6D2E726F77735B305D2C64293B656C73652066';
wwv_flow_api.g_varchar2_table(386) := '3D6E2E71756575655F77696467657428652E636F6C2C6F2C64293B656C736520663D6E2E71756575655F77696467657428652E636F6C2C6D2E726F77735B305D2C64293B656C736520663D6E2E71756575655F77696467657428672C652E726F772C6429';
wwv_flow_api.g_varchar2_table(387) := '3B656C7365206E2E6F7074696F6E732E6D6F76655F776964676574735F646F776E5F6F6E6C793F6A2E6561636828612E70726F78792866756E6374696F6E28622C63297B76617220643D612863293B6E2E63616E5F676F5F646F776E2864292626642E63';
wwv_flow_api.g_varchar2_table(388) := '6F6F72647328292E677269642E726F773D3D3D6E2E706C617965725F677269645F646174612E726F772626216E2E69735F696E5F717565756528642E636F6F72647328292E677269642E636F6C2C652E726F772C64292626286E2E6D6F76655F77696467';
wwv_flow_api.g_varchar2_table(389) := '65745F646F776E28642C6E2E706C617965725F677269645F646174612E73697A655F79292C6E2E7365745F706C616365686F6C64657228682C6929297D29293A663D6E2E71756575655F776964676574286D2E636F6C735B305D2C652E726F772C64293B';
wwv_flow_api.g_varchar2_table(390) := '656C7365206E2E6F7074696F6E732E73686966745F6C61726765725F776964676574735F646F776E2626216626266A2E6561636828612E70726F78792866756E6374696F6E28622C63297B76617220643D612863293B6E2E63616E5F676F5F646F776E28';
wwv_flow_api.g_varchar2_table(391) := '64292626642E636F6F72647328292E677269642E726F773D3D3D6E2E706C617965725F677269645F646174612E726F772626286E2E6D6F76655F7769646765745F646F776E28642C6E2E706C617965725F677269645F646174612E73697A655F79292C6E';
wwv_flow_api.g_varchar2_table(392) := '2E7365745F706C616365686F6C64657228682C6929297D29293B6E2E636C65616E5F75705F6368616E67656428297D29292C662626746869732E63616E5F706C616365686F6C6465725F62655F73657428682C692C6C2C6B29297B666F7228766172206F';
wwv_flow_api.g_varchar2_table(393) := '20696E20746869732E775F7175657565297B76617220703D7061727365496E74286F2E73706C697428225F22295B305D292C713D7061727365496E74286F2E73706C697428225F22295B315D293B2266756C6C22213D3D746869732E775F71756575655B';
wwv_flow_api.g_varchar2_table(394) := '6F5D2626746869732E6E65775F6D6F76655F7769646765745F746F28746869732E775F71756575655B6F5D2C702C71297D746869732E7365745F706C616365686F6C64657228682C69297D696628216A2E6C656E677468297B696628746869732E6F7074';
wwv_flow_api.g_varchar2_table(395) := '696F6E732E73686966745F776964676574735F7570297B76617220723D746869732E63616E5F676F5F706C617965725F757028746869732E706C617965725F677269645F64617461293B2131213D3D72262628693D72297D746869732E63616E5F706C61';
wwv_flow_api.g_varchar2_table(396) := '6365686F6C6465725F62655F73657428682C692C6C2C6B292626746869732E7365745F706C616365686F6C64657228682C69297D72657475726E20746869732E775F71756575653D7B7D2C7B636F6C3A682C726F773A697D7D2C682E69735F737761705F';
wwv_flow_api.g_varchar2_table(397) := '6F636375706965643D66756E6374696F6E28612C622C632C64297B666F722876617220653D21312C663D303B663C633B662B2B29666F722876617220673D303B673C643B672B2B297B76617220683D612B662C693D622B672C6A3D682B225F222B693B69';
wwv_flow_api.g_varchar2_table(398) := '6628746869732E69735F6F6363757069656428682C692929653D21303B656C7365206966286A20696E20746869732E775F7175657565297B6966282266756C6C223D3D3D746869732E775F71756575655B6A5D297B653D21303B636F6E74696E75657D76';
wwv_flow_api.g_varchar2_table(399) := '6172206B3D746869732E775F71756575655B6A5D2C6C3D6B2E636F6F72647328292E677269643B746869732E69735F7769646765745F756E6465725F706C61796572286C2E636F6C2C6C2E726F77297C7C64656C65746520746869732E775F7175657565';
wwv_flow_api.g_varchar2_table(400) := '5B6A5D7D693E7061727365496E7428746869732E6F7074696F6E732E6D61785F726F777329262628653D2130292C683E7061727365496E7428746869732E6F7074696F6E732E6D61785F636F6C7329262628653D2130292C746869732E69735F706C6179';
wwv_flow_api.g_varchar2_table(401) := '65725F696E28682C6929262628653D2130297D72657475726E20657D2C682E63616E5F706C616365686F6C6465725F62655F7365743D66756E6374696F6E28612C622C632C64297B666F722876617220653D21302C663D303B663C633B662B2B29666F72';
wwv_flow_api.g_varchar2_table(402) := '2876617220673D303B673C643B672B2B297B76617220683D612B662C693D622B672C6A3D746869732E69735F77696467657428682C69293B693E7061727365496E7428746869732E6F7074696F6E732E6D61785F726F777329262628653D2131292C683E';
wwv_flow_api.g_varchar2_table(403) := '7061727365496E7428746869732E6F7074696F6E732E6D61785F636F6C7329262628653D2131292C746869732E69735F6F6363757069656428682C6929262621746869732E69735F7769646765745F7175657565645F616E645F63616E5F6D6F7665286A';
wwv_flow_api.g_varchar2_table(404) := '29262628653D2131297D72657475726E20657D2C682E71756575655F7769646765743D66756E6374696F6E28612C622C63297B76617220643D632C653D642E636F6F72647328292E677269642C663D612B225F222B623B6966286620696E20746869732E';
wwv_flow_api.g_varchar2_table(405) := '775F71756575652972657475726E21313B746869732E775F71756575655B665D3D643B666F722876617220673D303B673C652E73697A655F783B672B2B29666F722876617220683D303B683C652E73697A655F793B682B2B297B76617220693D612B672C';
wwv_flow_api.g_varchar2_table(406) := '6A3D622B682C6B3D692B225F222B6A3B6B213D3D66262628746869732E775F71756575655B6B5D3D2266756C6C22297D72657475726E21307D2C682E69735F7769646765745F7175657565645F616E645F63616E5F6D6F76653D66756E6374696F6E2861';
wwv_flow_api.g_varchar2_table(407) := '297B76617220623D21313B69662821313D3D3D612972657475726E21313B666F7228766172206320696E20746869732E775F7175657565296966282266756C6C22213D3D746869732E775F71756575655B635D2626746869732E775F71756575655B635D';
wwv_flow_api.g_varchar2_table(408) := '2E617474722822646174612D636F6C22293D3D3D612E617474722822646174612D636F6C22292626746869732E775F71756575655B635D2E617474722822646174612D726F7722293D3D3D612E617474722822646174612D726F772229297B623D21303B';
wwv_flow_api.g_varchar2_table(409) := '666F722876617220643D746869732E775F71756575655B635D2C653D7061727365496E7428632E73706C697428225F22295B305D292C663D7061727365496E7428632E73706C697428225F22295B315D292C673D642E636F6F72647328292E677269642C';
wwv_flow_api.g_varchar2_table(410) := '683D303B683C672E73697A655F783B682B2B29666F722876617220693D303B693C672E73697A655F793B692B2B297B766172206A3D652B682C6B3D662B693B746869732E69735F706C617965725F696E286A2C6B29262628623D2131297D7D7265747572';
wwv_flow_api.g_varchar2_table(411) := '6E20627D2C682E69735F696E5F71756575653D66756E6374696F6E28612C622C63297B76617220643D21312C653D612B225F222B623B6966286520696E20746869732E775F7175657565296966282266756C6C223D3D3D746869732E775F71756575655B';
wwv_flow_api.g_varchar2_table(412) := '655D29643D21303B656C73657B76617220663D746869732E775F71756575655B655D2C673D662E636F6F72647328292E677269643B746869732E69735F7769646765745F756E6465725F706C6179657228672E636F6C2C672E726F77293F746869732E77';
wwv_flow_api.g_varchar2_table(413) := '5F71756575655B655D2E617474722822646174612D636F6C22293D3D3D632E617474722822646174612D636F6C22292626746869732E775F71756575655B655D2E617474722822646174612D726F7722293D3D3D632E617474722822646174612D726F77';
wwv_flow_api.g_varchar2_table(414) := '22293F2864656C65746520746869732E775F71756575655B655D2C643D2131293A643D21303A2864656C65746520746869732E775F71756575655B655D2C643D2131297D72657475726E20647D2C682E776964676574735F636F6E73747261696E74733D';
wwv_flow_api.g_varchar2_table(415) := '66756E6374696F6E2862297B76617220633D61285B5D292C653D5B5D2C663D5B5D3B72657475726E20622E6561636828612E70726F78792866756E6374696F6E28622C64297B76617220673D612864292C683D672E636F6F72647328292E677269643B74';
wwv_flow_api.g_varchar2_table(416) := '6869732E63616E5F676F5F7769646765745F75702868293F28633D632E6164642867292C652E70757368286829293A662E707573682868297D2C7468697329292C622E6E6F742863292C7B63616E5F676F5F75703A642E736F72745F62795F726F775F61';
wwv_flow_api.g_varchar2_table(417) := '73632865292C63616E5F6E6F745F676F5F75703A642E736F72745F62795F726F775F646573632866297D7D2C682E6D616E6167655F6D6F76656D656E74733D66756E6374696F6E28622C632C64297B72657475726E20612E6561636828622C612E70726F';
wwv_flow_api.g_varchar2_table(418) := '78792866756E6374696F6E28612C62297B76617220653D622C663D652E656C2C673D746869732E63616E5F676F5F7769646765745F75702865293B6966286729746869732E6D6F76655F7769646765745F746F28662C67292C746869732E7365745F706C';
wwv_flow_api.g_varchar2_table(419) := '616365686F6C64657228632C672B652E73697A655F79293B656C73657B69662821746869732E63616E5F676F5F706C617965725F757028746869732E706C617965725F677269645F6461746129297B76617220683D642B746869732E706C617965725F67';
wwv_flow_api.g_varchar2_table(420) := '7269645F646174612E73697A655F792D652E726F773B746869732E63616E5F676F5F646F776E286629262628636F6E736F6C652E6C6F672822496E204D6F766520446F776E2122292C746869732E6D6F76655F7769646765745F646F776E28662C68292C';
wwv_flow_api.g_varchar2_table(421) := '746869732E7365745F706C616365686F6C64657228632C6429297D7D7D2C7468697329292C746869737D2C682E69735F706C617965723D66756E6374696F6E28612C62297B69662862262621746869732E677269646D61705B615D2972657475726E2131';
wwv_flow_api.g_varchar2_table(422) := '3B76617220633D623F746869732E677269646D61705B615D5B625D3A613B72657475726E2063262628632E697328746869732E24706C61796572297C7C632E697328746869732E2468656C70657229297D2C682E69735F706C617965725F696E3D66756E';
wwv_flow_api.g_varchar2_table(423) := '6374696F6E28622C63297B76617220643D746869732E63656C6C735F6F636375706965645F62795F706C617965727C7C7B7D3B72657475726E20612E696E417272617928622C642E636F6C73293E3D302626612E696E417272617928632C642E726F7773';
wwv_flow_api.g_varchar2_table(424) := '293E3D307D2C682E69735F706C616365686F6C6465725F696E3D66756E6374696F6E28622C63297B76617220643D746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465727C7C7B7D3B72657475726E20746869732E69735F';
wwv_flow_api.g_varchar2_table(425) := '706C616365686F6C6465725F696E5F636F6C2862292626612E696E417272617928632C642E726F7773293E3D307D2C682E69735F706C616365686F6C6465725F696E5F636F6C3D66756E6374696F6E2862297B76617220633D746869732E63656C6C735F';
wwv_flow_api.g_varchar2_table(426) := '6F636375706965645F62795F706C616365686F6C6465727C7C5B5D3B72657475726E20612E696E417272617928622C632E636F6C73293E3D307D2C682E69735F656D7074793D66756E6374696F6E28612C62297B72657475726E20766F696420303D3D3D';
wwv_flow_api.g_varchar2_table(427) := '746869732E677269646D61705B615D7C7C21746869732E677269646D61705B615D5B625D7D2C682E69735F76616C69645F636F6C3D66756E6374696F6E28612C62297B72657475726E20746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F';
wwv_flow_api.g_varchar2_table(428) := '307C7C746869732E636F6C733E3D746869732E63616C63756C6174655F686967686573745F636F6C28612C62297D2C682E69735F76616C69645F726F773D66756E6374696F6E28612C62297B72657475726E20746869732E726F77733E3D746869732E63';
wwv_flow_api.g_varchar2_table(429) := '616C63756C6174655F686967686573745F726F7728612C62297D2C682E63616C63756C6174655F686967686573745F636F6C3D66756E6374696F6E28612C62297B72657475726E20612B28627C7C31292D317D2C682E63616C63756C6174655F68696768';
wwv_flow_api.g_varchar2_table(430) := '6573745F726F773D66756E6374696F6E28612C62297B72657475726E20612B28627C7C31292D317D2C682E69735F6F636375706965643D66756E6374696F6E28622C63297B72657475726E2121746869732E677269646D61705B625D2626282174686973';
wwv_flow_api.g_varchar2_table(431) := '2E69735F706C6179657228622C63292626282121746869732E677269646D61705B625D5B635D26262821746869732E6F7074696F6E732E69676E6F72655F73656C665F6F636375706965647C7C746869732E24706C617965722E646174612829213D3D61';
wwv_flow_api.g_varchar2_table(432) := '28746869732E677269646D61705B625D5B635D292E6461746128292929297D2C682E69735F7769646765743D66756E6374696F6E28612C62297B76617220633D746869732E677269646D61705B615D3B72657475726E21216326262828633D635B625D29';
wwv_flow_api.g_varchar2_table(433) := '7C7C2131297D2C682E69735F7374617469633D66756E6374696F6E28612C62297B76617220633D746869732E677269646D61705B615D3B72657475726E212163262621282128633D635B625D297C7C21632E686173436C61737328746869732E6F707469';
wwv_flow_api.g_varchar2_table(434) := '6F6E732E7374617469635F636C61737329297D2C682E69735F7769646765745F756E6465725F706C617965723D66756E6374696F6E28612C62297B72657475726E2121746869732E69735F77696467657428612C62292626746869732E69735F706C6179';
wwv_flow_api.g_varchar2_table(435) := '65725F696E28612C62297D2C682E6765745F776964676574735F756E6465725F706C617965723D66756E6374696F6E2862297B627C7C28623D746869732E63656C6C735F6F636375706965645F62795F706C617965727C7C7B636F6C733A5B5D2C726F77';
wwv_flow_api.g_varchar2_table(436) := '733A5B5D7D293B76617220633D61285B5D293B72657475726E20612E6561636828622E636F6C732C612E70726F78792866756E6374696F6E28642C65297B612E6561636828622E726F77732C612E70726F78792866756E6374696F6E28612C62297B7468';
wwv_flow_api.g_varchar2_table(437) := '69732E69735F77696467657428652C6229262628633D632E61646428746869732E677269646D61705B655D5B625D29297D2C7468697329297D2C7468697329292C637D2C682E7365745F706C616365686F6C6465723D66756E6374696F6E28622C63297B';
wwv_flow_api.g_varchar2_table(438) := '76617220643D612E657874656E64287B7D2C746869732E706C616365686F6C6465725F677269645F64617461292C653D622B642E73697A655F782D313B653E746869732E636F6C73262628622D3D652D62293B76617220663D746869732E706C61636568';
wwv_flow_api.g_varchar2_table(439) := '6F6C6465725F677269645F646174612E726F773C632C673D746869732E706C616365686F6C6465725F677269645F646174612E636F6C213D3D623B696628746869732E706C616365686F6C6465725F677269645F646174612E636F6C3D622C746869732E';
wwv_flow_api.g_varchar2_table(440) := '706C616365686F6C6465725F677269645F646174612E726F773D632C746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C6465723D746869732E6765745F63656C6C735F6F6363757069656428746869732E706C616365686F6C';
wwv_flow_api.g_varchar2_table(441) := '6465725F677269645F64617461292C746869732E24707265766965775F686F6C6465722E61747472287B22646174612D726F77223A632C22646174612D636F6C223A627D292C746869732E6F7074696F6E732E73686966745F706C617965725F7570297B';
wwv_flow_api.g_varchar2_table(442) := '696628667C7C67297B746869732E776964676574735F62656C6F77287B636F6C3A642E636F6C2C726F773A642E726F772C73697A655F793A642E73697A655F792C73697A655F783A642E73697A655F787D292E6561636828612E70726F78792866756E63';
wwv_flow_api.g_varchar2_table(443) := '74696F6E28622C63297B76617220643D612863292C653D642E636F6F72647328292E677269642C663D746869732E63616E5F676F5F7769646765745F75702865293B662626746869732E6D6F76655F7769646765745F746F28642C66297D2C7468697329';
wwv_flow_api.g_varchar2_table(444) := '297D76617220683D746869732E6765745F776964676574735F756E6465725F706C6179657228746869732E63656C6C735F6F636375706965645F62795F706C616365686F6C646572293B682E6C656E6774682626682E6561636828612E70726F78792866';
wwv_flow_api.g_varchar2_table(445) := '756E6374696F6E28622C65297B76617220663D612865293B746869732E6D6F76655F7769646765745F646F776E28662C632B642E73697A655F792D662E646174612822636F6F72647322292E677269642E726F77297D2C7468697329297D7D2C682E6361';
wwv_flow_api.g_varchar2_table(446) := '6E5F676F5F706C617965725F75703D66756E6374696F6E2861297B76617220623D612E726F772B612E73697A655F792D312C633D21302C643D5B5D2C653D3165342C663D746869732E6765745F776964676574735F756E6465725F706C6179657228293B';
wwv_flow_api.g_varchar2_table(447) := '72657475726E20746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428612C66756E6374696F6E2861297B76617220673D746869732E677269646D61705B615D2C683D622B313B666F7228645B615D3D5B5D3B2D2D683E3026262874';
wwv_flow_api.g_varchar2_table(448) := '6869732E69735F656D70747928612C68297C7C746869732E69735F706C6179657228612C68297C7C746869732E69735F77696467657428612C68292626675B685D2E6973286629293B29645B615D2E707573682868292C653D683C653F683A653B696628';
wwv_flow_api.g_varchar2_table(449) := '303D3D3D645B615D2E6C656E6774682972657475726E20633D21312C21303B645B615D2E736F72742866756E6374696F6E28612C62297B72657475726E20612D627D297D292C2121632626746869732E6765745F76616C69645F726F777328612C642C65';
wwv_flow_api.g_varchar2_table(450) := '297D2C682E63616E5F676F5F7769646765745F75703D66756E6374696F6E2861297B76617220623D612E726F772B612E73697A655F792D312C633D21302C643D5B5D2C653D3165343B72657475726E20746869732E666F725F656163685F636F6C756D6E';
wwv_flow_api.g_varchar2_table(451) := '5F6F6363757069656428612C66756E6374696F6E2866297B76617220673D746869732E677269646D61705B665D3B645B665D3D5B5D3B666F722876617220683D622B313B2D2D683E3026262821746869732E69735F77696467657428662C68297C7C7468';
wwv_flow_api.g_varchar2_table(452) := '69732E69735F706C617965725F696E28662C68297C7C675B685D2E697328612E656C29293B29746869732E69735F706C6179657228662C68297C7C746869732E69735F706C616365686F6C6465725F696E28662C68297C7C746869732E69735F706C6179';
wwv_flow_api.g_varchar2_table(453) := '65725F696E28662C68297C7C645B665D2E707573682868292C683C65262628653D68293B696628303D3D3D645B665D2E6C656E6774682972657475726E20633D21312C21303B645B665D2E736F72742866756E6374696F6E28612C62297B72657475726E';
wwv_flow_api.g_varchar2_table(454) := '20612D627D297D292C2121632626746869732E6765745F76616C69645F726F777328612C642C65297D2C682E6765745F76616C69645F726F77733D66756E6374696F6E28622C632C64297B666F722876617220653D622E726F772C663D622E726F772B62';
wwv_flow_api.g_varchar2_table(455) := '2E73697A655F792D312C673D622E73697A655F792C683D642D312C693D5B5D3B2B2B683C3D663B297B766172206A3D21303B696628612E6561636828632C66756E6374696F6E28622C63297B612E6973417272617928632926262D313D3D3D612E696E41';
wwv_flow_api.g_varchar2_table(456) := '7272617928682C63292626286A3D2131297D292C21303D3D3D6A262628692E707573682868292C692E6C656E6774683D3D3D672929627265616B7D766172206B3D21313B72657475726E20313D3D3D673F695B305D213D3D652626286B3D695B305D7C7C';
wwv_flow_api.g_varchar2_table(457) := '2131293A695B305D213D3D652626286B3D746869732E6765745F636F6E73656375746976655F6E756D626572735F696E64657828692C6729292C6B7D2C682E6765745F636F6E73656375746976655F6E756D626572735F696E6465783D66756E6374696F';
wwv_flow_api.g_varchar2_table(458) := '6E28612C62297B666F722876617220633D612E6C656E6774682C643D5B5D2C653D21302C663D2D312C673D303B673C633B672B2B297B696628657C7C615B675D3D3D3D662B31297B696628642E707573682867292C642E6C656E6774683D3D3D62296272';
wwv_flow_api.g_varchar2_table(459) := '65616B3B653D21317D656C736520643D5B5D2C653D21303B663D615B675D7D72657475726E20642E6C656E6774683E3D622626615B645B305D5D7D2C682E6765745F776964676574735F6F7665726C61707065643D66756E6374696F6E28297B76617220';
wwv_flow_api.g_varchar2_table(460) := '623D61285B5D292C633D5B5D2C643D746869732E63656C6C735F6F636375706965645F62795F706C617965722E726F77732E736C6963652830293B72657475726E20642E7265766572736528292C612E6561636828746869732E63656C6C735F6F636375';
wwv_flow_api.g_varchar2_table(461) := '706965645F62795F706C617965722E636F6C732C612E70726F78792866756E6374696F6E28652C66297B612E6561636828642C612E70726F78792866756E6374696F6E28642C65297B69662821746869732E677269646D61705B665D2972657475726E21';
wwv_flow_api.g_varchar2_table(462) := '303B76617220673D746869732E677269646D61705B665D5B655D3B746869732E69735F6F6363757069656428662C6529262621746869732E69735F706C6179657228672926262D313D3D3D612E696E417272617928672C6329262628623D622E61646428';
wwv_flow_api.g_varchar2_table(463) := '67292C632E70757368286729297D2C7468697329297D2C7468697329292C627D2C682E6F6E5F73746172745F6F7665726C617070696E675F636F6C756D6E3D66756E6374696F6E2861297B746869732E7365745F706C6179657228612C766F696420302C';
wwv_flow_api.g_varchar2_table(464) := '2131297D2C682E6F6E5F73746172745F6F7665726C617070696E675F726F773D66756E6374696F6E2861297B746869732E7365745F706C6179657228766F696420302C612C2131297D2C682E6F6E5F73746F705F6F7665726C617070696E675F636F6C75';
wwv_flow_api.g_varchar2_table(465) := '6D6E3D66756E6374696F6E2861297B76617220623D746869733B746869732E6F7074696F6E732E73686966745F6C61726765725F776964676574735F646F776E2626746869732E666F725F656163685F7769646765745F62656C6F7728612C746869732E';
wwv_flow_api.g_varchar2_table(466) := '63656C6C735F6F636375706965645F62795F706C617965722E726F77735B305D2C66756E6374696F6E28612C63297B622E6D6F76655F7769646765745F757028746869732C622E706C617965725F677269645F646174612E73697A655F79297D297D2C68';
wwv_flow_api.g_varchar2_table(467) := '2E6F6E5F73746F705F6F7665726C617070696E675F726F773D66756E6374696F6E2861297B76617220623D746869732C633D746869732E63656C6C735F6F636375706965645F62795F706C617965722E636F6C733B696628746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(468) := '2E73686966745F6C61726765725F776964676574735F646F776E29666F722876617220643D302C653D632E6C656E6774683B643C653B642B2B29746869732E666F725F656163685F7769646765745F62656C6F7728635B645D2C612C66756E6374696F6E';
wwv_flow_api.g_varchar2_table(469) := '28612C63297B622E6D6F76655F7769646765745F757028746869732C622E706C617965725F677269645F646174612E73697A655F79297D297D2C682E6E65775F6D6F76655F7769646765745F746F3D66756E6374696F6E28612C622C63297B7661722064';
wwv_flow_api.g_varchar2_table(470) := '3D612E636F6F72647328292E677269643B72657475726E20746869732E72656D6F76655F66726F6D5F677269646D61702864292C642E726F773D632C642E636F6C3D622C746869732E6164645F746F5F677269646D61702864292C612E61747472282264';
wwv_flow_api.g_varchar2_table(471) := '6174612D726F77222C63292C612E617474722822646174612D636F6C222C62292C746869732E7570646174655F7769646765745F706F736974696F6E28642C61292C746869732E246368616E6765643D746869732E246368616E6765642E616464286129';
wwv_flow_api.g_varchar2_table(472) := '2C746869737D2C682E6D6F76655F7769646765743D66756E6374696F6E28612C622C632C64297B76617220653D612E636F6F72647328292E677269642C663D7B636F6C3A622C726F773A632C73697A655F783A652E73697A655F782C73697A655F793A65';
wwv_flow_api.g_varchar2_table(473) := '2E73697A655F797D3B72657475726E20746869732E6D75746174655F7769646765745F696E5F677269646D617028612C652C66292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F6D5F677269645F7769';
wwv_flow_api.g_varchar2_table(474) := '64746828292C642626642E63616C6C28746869732C662E636F6C2C662E726F77292C617D2C682E6D6F76655F7769646765745F746F3D66756E6374696F6E28622C63297B76617220643D746869732C653D622E636F6F72647328292E677269642C663D74';
wwv_flow_api.g_varchar2_table(475) := '6869732E776964676574735F62656C6F772862293B72657475726E2131213D3D746869732E63616E5F6D6F76655F746F28652C652E636F6C2C6329262628746869732E72656D6F76655F66726F6D5F677269646D61702865292C652E726F773D632C7468';
wwv_flow_api.g_varchar2_table(476) := '69732E6164645F746F5F677269646D61702865292C622E617474722822646174612D726F77222C63292C746869732E246368616E6765643D746869732E246368616E6765642E6164642862292C662E656163682866756E6374696F6E28622C63297B7661';
wwv_flow_api.g_varchar2_table(477) := '7220653D612863292C663D652E636F6F72647328292E677269642C673D642E63616E5F676F5F7769646765745F75702866293B67262667213D3D662E726F772626642E6D6F76655F7769646765745F746F28652C67297D292C74686973297D2C682E6D6F';
wwv_flow_api.g_varchar2_table(478) := '76655F7769646765745F75703D66756E6374696F6E28622C63297B696628766F696420303D3D3D632972657475726E21313B76617220643D622E636F6F72647328292E677269642C653D642E726F772C663D5B5D3B696628637C7C28633D31292C217468';
wwv_flow_api.g_varchar2_table(479) := '69732E63616E5F676F5F75702862292972657475726E21313B746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428642C66756E6374696F6E2864297B6966282D313D3D3D612E696E417272617928622C6629297B76617220673D62';
wwv_flow_api.g_varchar2_table(480) := '2E636F6F72647328292E677269642C683D652D633B6966282128683D746869732E63616E5F676F5F75705F746F5F726F7728672C642C6829292972657475726E21303B746869732E72656D6F76655F66726F6D5F677269646D61702867292C672E726F77';
wwv_flow_api.g_varchar2_table(481) := '3D682C746869732E6164645F746F5F677269646D61702867292C622E617474722822646174612D726F77222C672E726F77292C746869732E246368616E6765643D746869732E246368616E6765642E6164642862292C662E707573682862297D7D297D2C';
wwv_flow_api.g_varchar2_table(482) := '682E6D6F76655F7769646765745F646F776E3D66756E6374696F6E28622C63297B76617220642C652C662C673B696628633C3D302972657475726E21313B696628643D622E636F6F72647328292E677269642C28653D642E726F77292B28622E636F6F72';
wwv_flow_api.g_varchar2_table(483) := '647328292E677269642E73697A655F792D31292B633E746869732E6F7074696F6E732E6D61785F726F77732972657475726E21313B696628663D5B5D2C673D632C21622972657475726E21313B696628746869732E6661696C65643D21312C2D313D3D3D';
wwv_flow_api.g_varchar2_table(484) := '612E696E417272617928622C6629297B76617220683D622E636F6F72647328292E677269642C693D652B633B696628746869732E776964676574735F62656C6F772862292E6561636828612E70726F78792866756E6374696F6E28622C63297B69662821';
wwv_flow_api.g_varchar2_table(485) := '30213D3D746869732E6661696C6564297B76617220643D612863292C653D642E636F6F72647328292E677269642C663D746869732E646973706C6163656D656E745F6469666628652C682C67293B663E30262628746869732E6661696C65643D21313D3D';
wwv_flow_api.g_varchar2_table(486) := '3D746869732E6D6F76655F7769646765745F646F776E28642C6629297D7D2C7468697329292C746869732E6661696C65642972657475726E21313B746869732E72656D6F76655F66726F6D5F677269646D61702868292C682E726F773D692C746869732E';
wwv_flow_api.g_varchar2_table(487) := '7570646174655F7769646765745F706F736974696F6E28682C62292C622E617474722822646174612D726F77222C682E726F77292C746869732E246368616E6765643D746869732E246368616E6765642E6164642862292C662E707573682862297D7265';
wwv_flow_api.g_varchar2_table(488) := '7475726E21307D2C682E63616E5F676F5F75705F746F5F726F773D66756E6374696F6E28622C632C64297B76617220652C663D21302C673D5B5D2C683D622E726F773B696628746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428';
wwv_flow_api.g_varchar2_table(489) := '622C66756E6374696F6E2861297B666F7228675B615D3D5B5D2C653D683B652D2D2626746869732E69735F656D70747928612C6529262621746869732E69735F706C616365686F6C6465725F696E28612C65293B29675B615D2E707573682865293B6966';
wwv_flow_api.g_varchar2_table(490) := '2821675B615D2E6C656E6774682972657475726E20663D21312C21307D292C21662972657475726E21313B666F7228653D642C653D313B653C683B652B2B297B666F722876617220693D21302C6A3D302C6B3D672E6C656E6774683B6A3C6B3B6A2B2B29';
wwv_flow_api.g_varchar2_table(491) := '675B6A5D26262D313D3D3D612E696E417272617928652C675B6A5D29262628693D2131293B69662821303D3D3D69297B663D653B627265616B7D7D72657475726E20667D2C682E646973706C6163656D656E745F646966663D66756E6374696F6E28612C';
wwv_flow_api.g_varchar2_table(492) := '622C63297B76617220643D612E726F772C653D5B5D2C663D622E726F772B622E73697A655F793B72657475726E20746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428612C66756E6374696F6E2861297B666F722876617220623D';
wwv_flow_api.g_varchar2_table(493) := '302C633D663B633C643B632B2B29746869732E69735F656D70747928612C6329262628622B3D31293B652E707573682862297D292C632D3D4D6174682E6D61782E6170706C79284D6174682C65292C633E303F633A307D2C682E776964676574735F6265';
wwv_flow_api.g_varchar2_table(494) := '6C6F773D66756E6374696F6E2862297B76617220633D61285B5D292C653D612E6973506C61696E4F626A6563742862293F623A622E636F6F72647328292E677269643B696628766F696420303D3D3D652972657475726E20633B76617220663D74686973';
wwv_flow_api.g_varchar2_table(495) := '2C673D652E726F772B652E73697A655F792D313B72657475726E20746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428652C66756E6374696F6E2862297B662E666F725F656163685F7769646765745F62656C6F7728622C672C66';
wwv_flow_api.g_varchar2_table(496) := '756E6374696F6E28622C64297B69662821662E69735F706C6179657228746869732926262D313D3D3D612E696E417272617928746869732C63292972657475726E20633D632E6164642874686973292C21307D297D292C642E736F72745F62795F726F77';
wwv_flow_api.g_varchar2_table(497) := '5F6173632863297D2C682E7365745F63656C6C735F706C617965725F6F636375706965733D66756E6374696F6E28612C62297B72657475726E20746869732E72656D6F76655F66726F6D5F677269646D617028746869732E706C616365686F6C6465725F';
wwv_flow_api.g_varchar2_table(498) := '677269645F64617461292C746869732E706C616365686F6C6465725F677269645F646174612E636F6C3D612C746869732E706C616365686F6C6465725F677269645F646174612E726F773D622C746869732E6164645F746F5F677269646D617028746869';
wwv_flow_api.g_varchar2_table(499) := '732E706C616365686F6C6465725F677269645F646174612C746869732E24706C61796572292C746869737D2C682E656D7074795F63656C6C735F706C617965725F6F636375706965733D66756E6374696F6E28297B72657475726E20746869732E72656D';
wwv_flow_api.g_varchar2_table(500) := '6F76655F66726F6D5F677269646D617028746869732E706C616365686F6C6465725F677269645F64617461292C746869737D2C682E63616E5F676F5F646F776E3D66756E6374696F6E2862297B76617220633D21302C643D746869733B72657475726E20';
wwv_flow_api.g_varchar2_table(501) := '622E686173436C61737328746869732E6F7074696F6E732E7374617469635F636C61737329262628633D2131292C746869732E776964676574735F62656C6F772862292E656163682866756E6374696F6E28297B612874686973292E686173436C617373';
wwv_flow_api.g_varchar2_table(502) := '28642E6F7074696F6E732E7374617469635F636C61737329262628633D2131297D292C637D2C682E63616E5F676F5F75703D66756E6374696F6E2861297B76617220623D612E636F6F72647328292E677269642C633D622E726F772C643D632D312C653D';
wwv_flow_api.g_varchar2_table(503) := '21303B72657475726E2031213D3D63262628746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428622C66756E6374696F6E2861297B696628746869732E69735F6F6363757069656428612C64297C7C746869732E69735F706C6179';
wwv_flow_api.g_varchar2_table(504) := '657228612C64297C7C746869732E69735F706C616365686F6C6465725F696E28612C64297C7C746869732E69735F706C617965725F696E28612C64292972657475726E20653D21312C21307D292C65297D2C682E63616E5F6D6F76655F746F3D66756E63';
wwv_flow_api.g_varchar2_table(505) := '74696F6E28612C622C63297B76617220643D612E656C2C653D7B73697A655F793A612E73697A655F792C73697A655F783A612E73697A655F782C636F6C3A622C726F773A637D2C663D21303B696628746869732E6F7074696F6E732E6D61785F636F6C73';
wwv_flow_api.g_varchar2_table(506) := '213D3D312F30297B696628622B612E73697A655F782D313E746869732E636F6C732972657475726E21317D72657475726E2128746869732E6F7074696F6E732E6D61785F726F77733C632B612E73697A655F792D3129262628746869732E666F725F6561';
wwv_flow_api.g_varchar2_table(507) := '63685F63656C6C5F6F6363757069656428652C66756E6374696F6E28622C63297B76617220653D746869732E69735F77696467657428622C63293B21657C7C612E656C262621652E69732864297C7C28663D2131297D292C66297D2C682E6765745F7461';
wwv_flow_api.g_varchar2_table(508) := '7267657465645F636F6C756D6E733D66756E6374696F6E2861297B666F722876617220623D28617C7C746869732E706C617965725F677269645F646174612E636F6C292B28746869732E706C617965725F677269645F646174612E73697A655F782D3129';
wwv_flow_api.g_varchar2_table(509) := '2C633D5B5D2C643D613B643C3D623B642B2B29632E707573682864293B72657475726E20637D2C682E6765745F74617267657465645F726F77733D66756E6374696F6E2861297B666F722876617220623D28617C7C746869732E706C617965725F677269';
wwv_flow_api.g_varchar2_table(510) := '645F646174612E726F77292B28746869732E706C617965725F677269645F646174612E73697A655F792D31292C633D5B5D2C643D613B643C3D623B642B2B29632E707573682864293B72657475726E20637D2C682E6765745F63656C6C735F6F63637570';
wwv_flow_api.g_varchar2_table(511) := '6965643D66756E6374696F6E2862297B76617220632C643D7B636F6C733A5B5D2C726F77733A5B5D7D3B666F7228617267756D656E74735B315D696E7374616E63656F662061262628623D617267756D656E74735B315D2E636F6F72647328292E677269';
wwv_flow_api.g_varchar2_table(512) := '64292C633D303B633C622E73697A655F783B632B2B297B76617220653D622E636F6C2B633B642E636F6C732E707573682865297D666F7228633D303B633C622E73697A655F793B632B2B297B76617220663D622E726F772B633B642E726F77732E707573';
wwv_flow_api.g_varchar2_table(513) := '682866297D72657475726E20647D2C682E666F725F656163685F63656C6C5F6F636375706965643D66756E6374696F6E28612C62297B72657475726E20746869732E666F725F656163685F636F6C756D6E5F6F6363757069656428612C66756E6374696F';
wwv_flow_api.g_varchar2_table(514) := '6E2863297B746869732E666F725F656163685F726F775F6F6363757069656428612C66756E6374696F6E2861297B622E63616C6C28746869732C632C61297D297D292C746869737D2C682E666F725F656163685F636F6C756D6E5F6F636375706965643D';
wwv_flow_api.g_varchar2_table(515) := '66756E6374696F6E28612C62297B666F722876617220633D303B633C612E73697A655F783B632B2B297B76617220643D612E636F6C2B633B622E63616C6C28746869732C642C61297D7D2C682E666F725F656163685F726F775F6F636375706965643D66';
wwv_flow_api.g_varchar2_table(516) := '756E6374696F6E28612C62297B666F722876617220633D303B633C612E73697A655F793B632B2B297B76617220643D612E726F772B633B622E63616C6C28746869732C642C61297D7D2C682E636C65616E5F75705F6368616E6765643D66756E6374696F';
wwv_flow_api.g_varchar2_table(517) := '6E28297B76617220623D746869733B622E246368616E6765642E656163682866756E6374696F6E28297B622E6F7074696F6E732E73686966745F6C61726765725F776964676574735F646F776E2626622E6D6F76655F7769646765745F75702861287468';
wwv_flow_api.g_varchar2_table(518) := '697329297D297D2C682E5F74726176657273696E675F776964676574733D66756E6374696F6E28622C632C642C652C66297B76617220673D746869732E677269646D61703B696628675B645D297B76617220682C692C6A3D622B222F222B633B69662861';
wwv_flow_api.g_varchar2_table(519) := '7267756D656E74735B325D696E7374616E63656F662061297B766172206B3D617267756D656E74735B325D2E636F6F72647328292E677269643B643D6B2E636F6C2C653D6B2E726F772C663D617267756D656E74735B335D7D766172206C3D5B5D2C6D3D';
wwv_flow_api.g_varchar2_table(520) := '652C6E3D7B22666F725F656163682F61626F7665223A66756E6374696F6E28297B666F72283B6D2D2D262621286D3E302626746869732E69735F77696467657428642C6D2926262D313D3D3D612E696E417272617928675B645D5B6D5D2C6C2926262868';
wwv_flow_api.g_varchar2_table(521) := '3D662E63616C6C28675B645D5B6D5D2C642C6D292C6C2E7075736828675B645D5B6D5D292C6829293B293B7D2C22666F725F656163682F62656C6F77223A66756E6374696F6E28297B666F72286D3D652B312C693D675B645D2E6C656E6774683B6D3C69';
wwv_flow_api.g_varchar2_table(522) := '3B6D2B2B29746869732E69735F77696467657428642C6D2926262D313D3D3D612E696E417272617928675B645D5B6D5D2C6C29262628683D662E63616C6C28675B645D5B6D5D2C642C6D292C6C2E7075736828675B645D5B6D5D29297D7D3B6E5B6A5D26';
wwv_flow_api.g_varchar2_table(523) := '266E5B6A5D2E63616C6C2874686973297D7D2C682E666F725F656163685F7769646765745F61626F76653D66756E6374696F6E28612C622C63297B72657475726E20746869732E5F74726176657273696E675F776964676574732822666F725F65616368';
wwv_flow_api.g_varchar2_table(524) := '222C2261626F7665222C612C622C63292C746869737D2C682E666F725F656163685F7769646765745F62656C6F773D66756E6374696F6E28612C622C63297B72657475726E20746869732E5F74726176657273696E675F776964676574732822666F725F';
wwv_flow_api.g_varchar2_table(525) := '65616368222C2262656C6F77222C612C622C63292C746869737D2C682E6765745F686967686573745F6F636375706965645F63656C6C3D66756E6374696F6E28297B666F722876617220612C623D746869732E677269646D61702C633D625B315D2E6C65';
wwv_flow_api.g_varchar2_table(526) := '6E6774682C643D5B5D2C653D5B5D2C663D622E6C656E6774682D313B663E3D313B662D2D29666F7228613D632D313B613E3D313B612D2D29696628746869732E69735F77696467657428662C6129297B642E707573682861292C652E707573682866293B';
wwv_flow_api.g_varchar2_table(527) := '627265616B7D72657475726E7B636F6C3A4D6174682E6D61782E6170706C79284D6174682C65292C726F773A4D6174682E6D61782E6170706C79284D6174682C64297D7D2C682E6765745F776964676574735F696E5F72616E67653D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(528) := '28622C632C642C65297B76617220662C672C682C692C6A3D61285B5D293B666F7228663D643B663E3D623B662D2D29666F7228673D653B673E3D633B672D2D292131213D3D28683D746869732E69735F77696467657428662C672929262628693D682E64';
wwv_flow_api.g_varchar2_table(529) := '6174612822636F6F72647322292E677269642C692E636F6C3E3D622626692E636F6C3C3D642626692E726F773E3D632626692E726F773C3D652626286A3D6A2E61646428682929293B72657475726E206A7D2C682E6765745F776964676574735F61745F';
wwv_flow_api.g_varchar2_table(530) := '63656C6C3D66756E6374696F6E28612C62297B72657475726E20746869732E6765745F776964676574735F696E5F72616E676528612C622C612C62297D2C682E6765745F776964676574735F66726F6D3D66756E6374696F6E28622C63297B7661722064';
wwv_flow_api.g_varchar2_table(531) := '3D6128293B72657475726E2062262628643D642E61646428746869732E24776964676574732E66696C7465722866756E6374696F6E28297B76617220633D7061727365496E7428612874686973292E617474722822646174612D636F6C2229293B726574';
wwv_flow_api.g_varchar2_table(532) := '75726E20633D3D3D627C7C633E627D2929292C63262628643D642E61646428746869732E24776964676574732E66696C7465722866756E6374696F6E28297B76617220623D7061727365496E7428612874686973292E617474722822646174612D726F77';
wwv_flow_api.g_varchar2_table(533) := '2229293B72657475726E20623D3D3D637C7C623E637D2929292C647D2C682E7365745F646F6D5F677269645F6865696768743D66756E6374696F6E2861297B696628766F696420303D3D3D61297B76617220623D746869732E6765745F68696768657374';
wwv_flow_api.g_varchar2_table(534) := '5F6F636375706965645F63656C6C28292E726F773B613D28622B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D2B622A746869732E6D696E5F7769646765745F6865696768747D72657475726E20746869732E636F6E';
wwv_flow_api.g_varchar2_table(535) := '7461696E65725F6865696768743D612C746869732E24656C2E6373732822686569676874222C746869732E636F6E7461696E65725F686569676874292C746869737D2C682E7365745F646F6D5F677269645F77696474683D66756E6374696F6E2861297B';
wwv_flow_api.g_varchar2_table(536) := '766F696420303D3D3D61262628613D746869732E6765745F686967686573745F6F636375706965645F63656C6C28292E636F6C293B76617220623D746869732E6F7074696F6E732E6D61785F636F6C733D3D3D312F303F746869732E6F7074696F6E732E';
wwv_flow_api.g_varchar2_table(537) := '6D61785F636F6C733A746869732E636F6C733B72657475726E20613D4D6174682E6D696E28622C4D6174682E6D617828612C746869732E6F7074696F6E732E6D696E5F636F6C7329292C746869732E636F6E7461696E65725F77696474683D28612B3129';
wwv_flow_api.g_varchar2_table(538) := '2A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2B612A746869732E6D696E5F7769646765745F77696474682C746869732E69735F726573706F6E7369766528293F28746869732E24656C2E637373287B226D696E2D776964';
wwv_flow_api.g_varchar2_table(539) := '7468223A2231303025222C226D61782D7769647468223A2231303025227D292C74686973293A28746869732E24656C2E63737328227769647468222C746869732E636F6E7461696E65725F7769647468292C74686973297D2C682E69735F726573706F6E';
wwv_flow_api.g_varchar2_table(540) := '736976653D66756E6374696F6E28297B72657475726E20746869732E6F7074696F6E732E6175746F67656E65726174655F7374796C6573686565742626226175746F223D3D3D746869732E6F7074696F6E732E7769646765745F626173655F64696D656E';
wwv_flow_api.g_varchar2_table(541) := '73696F6E735B305D2626746869732E6F7074696F6E732E6D61785F636F6C73213D3D312F307D2C682E6765745F726573706F6E736976655F636F6C5F77696474683D66756E6374696F6E28297B76617220613D746869732E636F6C737C7C746869732E6F';
wwv_flow_api.g_varchar2_table(542) := '7074696F6E732E6D61785F636F6C733B72657475726E28746869732E24656C5B305D2E636C69656E7457696474682D332D28612B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D292F617D2C682E726573697A655F72';
wwv_flow_api.g_varchar2_table(543) := '6573706F6E736976655F6C61796F75743D66756E6374696F6E28297B72657475726E20746869732E6D696E5F7769646765745F77696474683D746869732E6765745F726573706F6E736976655F636F6C5F776964746828292C746869732E67656E657261';
wwv_flow_api.g_varchar2_table(544) := '74655F7374796C65736865657428292C746869732E7570646174655F776964676574735F64696D656E73696F6E7328292C746869732E647261675F6170692E7365745F6C696D69747328746869732E636F6C732A746869732E6D696E5F7769646765745F';
wwv_flow_api.g_varchar2_table(545) := '77696474682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D292C746869737D2C682E746F67676C655F636F6C6C61707365645F677269643D66756E6374696F6E28612C62297B72657475';
wwv_flow_api.g_varchar2_table(546) := '726E20613F28746869732E24776964676574732E637373287B226D617267696E2D746F70223A622E7769646765745F6D617267696E735B305D2C226D617267696E2D626F74746F6D223A622E7769646765745F6D617267696E735B305D2C226D696E2D68';
wwv_flow_api.g_varchar2_table(547) := '6569676874223A622E7769646765745F626173655F64696D656E73696F6E735B315D7D292C746869732E24656C2E616464436C6173732822636F6C6C617073656422292C746869732E726573697A655F6170692626746869732E64697361626C655F7265';
wwv_flow_api.g_varchar2_table(548) := '73697A6528292C746869732E647261675F6170692626746869732E64697361626C652829293A28746869732E24776964676574732E637373287B226D617267696E2D746F70223A226175746F222C226D617267696E2D626F74746F6D223A226175746F22';
wwv_flow_api.g_varchar2_table(549) := '2C226D696E2D686569676874223A226175746F227D292C746869732E24656C2E72656D6F7665436C6173732822636F6C6C617073656422292C746869732E726573697A655F6170692626746869732E656E61626C655F726573697A6528292C746869732E';
wwv_flow_api.g_varchar2_table(550) := '647261675F6170692626746869732E656E61626C652829292C746869737D2C682E67656E65726174655F7374796C6573686565743D66756E6374696F6E2862297B76617220632C653D22222C663D746869732E69735F726573706F6E7369766528292626';
wwv_flow_api.g_varchar2_table(551) := '746869732E6F7074696F6E732E726573706F6E736976655F627265616B706F696E742626612877696E646F77292E776964746828293C746869732E6F7074696F6E732E726573706F6E736976655F627265616B706F696E743B627C7C28623D7B7D292C62';
wwv_flow_api.g_varchar2_table(552) := '2E636F6C737C7C28622E636F6C733D746869732E636F6C73292C622E726F77737C7C28622E726F77733D746869732E726F7773292C622E6E616D6573706163657C7C28622E6E616D6573706163653D746869732E6F7074696F6E732E6E616D6573706163';
wwv_flow_api.g_varchar2_table(553) := '65292C622E7769646765745F626173655F64696D656E73696F6E737C7C28622E7769646765745F626173655F64696D656E73696F6E733D746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E73292C622E776964676574';
wwv_flow_api.g_varchar2_table(554) := '5F6D617267696E737C7C28622E7769646765745F6D617267696E733D746869732E6F7074696F6E732E7769646765745F6D617267696E73292C746869732E69735F726573706F6E736976652829262628622E7769646765745F626173655F64696D656E73';
wwv_flow_api.g_varchar2_table(555) := '696F6E733D5B746869732E6765745F726573706F6E736976655F636F6C5F776964746828292C622E7769646765745F626173655F64696D656E73696F6E735B315D5D2C746869732E746F67676C655F636F6C6C61707365645F6772696428662C6229293B';
wwv_flow_api.g_varchar2_table(556) := '76617220673D612E706172616D2862293B696628612E696E417272617928672C642E67656E6572617465645F7374796C65736865657473293E3D302972657475726E21313B666F7228746869732E67656E6572617465645F7374796C657368656574732E';
wwv_flow_api.g_varchar2_table(557) := '707573682867292C642E67656E6572617465645F7374796C657368656574732E707573682867292C633D313B633C3D622E636F6C732B313B632B2B29652B3D622E6E616D6573706163652B27205B646174612D636F6C3D22272B632B27225D207B206C65';
wwv_flow_api.g_varchar2_table(558) := '66743A272B28663F746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D3A632A622E7769646765745F6D617267696E735B305D2B28632D31292A622E7769646765745F626173655F64696D656E73696F6E735B305D292B2270783B';
wwv_flow_api.g_varchar2_table(559) := '207D5C6E223B666F7228633D313B633C3D622E726F77732B313B632B2B29652B3D622E6E616D6573706163652B27205B646174612D726F773D22272B632B27225D207B20746F703A272B28632A622E7769646765745F6D617267696E735B315D2B28632D';
wwv_flow_api.g_varchar2_table(560) := '31292A622E7769646765745F626173655F64696D656E73696F6E735B315D292B2270783B207D5C6E223B666F722876617220683D313B683C3D622E726F77733B682B2B29652B3D622E6E616D6573706163652B27205B646174612D73697A65793D22272B';
wwv_flow_api.g_varchar2_table(561) := '682B27225D207B206865696768743A272B28663F226175746F223A682A622E7769646765745F626173655F64696D656E73696F6E735B315D2B28682D31292A622E7769646765745F6D617267696E735B315D292B28663F22223A22707822292B223B207D';
wwv_flow_api.g_varchar2_table(562) := '5C6E223B666F722876617220693D313B693C3D622E636F6C733B692B2B297B766172206A3D692A622E7769646765745F626173655F64696D656E73696F6E735B305D2B28692D31292A622E7769646765745F6D617267696E735B305D3B652B3D622E6E61';
wwv_flow_api.g_varchar2_table(563) := '6D6573706163652B27205B646174612D73697A65783D22272B692B27225D207B2077696474683A272B28663F746869732E24777261707065722E776964746828292D322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D3A6A';
wwv_flow_api.g_varchar2_table(564) := '3E746869732E24777261707065722E776964746828293F746869732E24777261707065722E776964746828293A6A292B2270783B207D5C6E227D72657475726E20746869732E72656D6F76655F7374796C655F7461677328292C746869732E6164645F73';
wwv_flow_api.g_varchar2_table(565) := '74796C655F7461672865297D2C682E6164645F7374796C655F7461673D66756E6374696F6E2861297B76617220623D646F63756D656E742C633D2267726964737465722D7374796C657368656574223B6966282222213D3D746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(566) := '2E6E616D657370616365262628633D632B222D222B746869732E6F7074696F6E732E6E616D657370616365292C21646F63756D656E742E676574456C656D656E7442794964286329297B76617220643D622E637265617465456C656D656E742822737479';
wwv_flow_api.g_varchar2_table(567) := '6C6522293B642E69643D632C622E676574456C656D656E747342795461674E616D6528226865616422295B305D2E617070656E644368696C642864292C642E736574417474726962757465282274797065222C22746578742F63737322292C642E737479';
wwv_flow_api.g_varchar2_table(568) := '6C6553686565743F642E7374796C6553686565742E637373546578743D613A642E617070656E644368696C6428646F63756D656E742E637265617465546578744E6F6465286129292C746869732E72656D6F76655F7374796C655F7461677328292C7468';
wwv_flow_api.g_varchar2_table(569) := '69732E247374796C655F746167733D746869732E247374796C655F746167732E6164642864297D72657475726E20746869737D2C682E72656D6F76655F7374796C655F746167733D66756E6374696F6E28297B76617220623D642E67656E657261746564';
wwv_flow_api.g_varchar2_table(570) := '5F7374796C657368656574732C633D746869732E67656E6572617465645F7374796C657368656574733B746869732E247374796C655F746167732E72656D6F766528292C642E67656E6572617465645F7374796C657368656574733D612E6D617028622C';
wwv_flow_api.g_varchar2_table(571) := '66756E6374696F6E2862297B6966282D313D3D3D612E696E417272617928622C63292972657475726E20627D297D2C682E67656E65726174655F666175785F677269643D66756E6374696F6E28612C62297B746869732E666175785F677269643D5B5D2C';
wwv_flow_api.g_varchar2_table(572) := '746869732E677269646D61703D5B5D3B76617220632C643B666F7228633D623B633E303B632D2D29666F7228746869732E677269646D61705B635D3D5B5D2C643D613B643E303B642D2D29746869732E6164645F666175785F63656C6C28642C63293B72';
wwv_flow_api.g_varchar2_table(573) := '657475726E20746869737D2C682E6164645F666175785F63656C6C3D66756E6374696F6E28622C63297B76617220643D61287B6C6566743A746869732E62617365582B28632D31292A746869732E6D696E5F7769646765745F77696474682C746F703A74';
wwv_flow_api.g_varchar2_table(574) := '6869732E62617365592B28622D31292A746869732E6D696E5F7769646765745F6865696768742C77696474683A746869732E6D696E5F7769646765745F77696474682C6865696768743A746869732E6D696E5F7769646765745F6865696768742C636F6C';
wwv_flow_api.g_varchar2_table(575) := '3A632C726F773A622C6F726967696E616C5F636F6C3A632C6F726967696E616C5F726F773A627D292E636F6F72647328293B72657475726E20612E6973417272617928746869732E677269646D61705B635D297C7C28746869732E677269646D61705B63';
wwv_flow_api.g_varchar2_table(576) := '5D3D5B5D292C766F696420303D3D3D746869732E677269646D61705B635D5B625D262628746869732E677269646D61705B635D5B625D3D2131292C746869732E666175785F677269642E707573682864292C746869737D2C682E6164645F666175785F72';
wwv_flow_api.g_varchar2_table(577) := '6F77733D66756E6374696F6E2861297B613D77696E646F772E7061727365496E7428612C3130293B666F722876617220623D746869732E726F77732C633D622B7061727365496E7428617C7C31292C643D633B643E623B642D2D29666F72287661722065';
wwv_flow_api.g_varchar2_table(578) := '3D746869732E636F6C733B653E3D313B652D2D29746869732E6164645F666175785F63656C6C28642C65293B72657475726E20746869732E726F77733D632C746869732E6F7074696F6E732E6175746F67656E65726174655F7374796C65736865657426';
wwv_flow_api.g_varchar2_table(579) := '26746869732E67656E65726174655F7374796C65736865657428292C746869737D2C682E6164645F666175785F636F6C733D66756E6374696F6E2861297B613D77696E646F772E7061727365496E7428612C3130293B76617220623D746869732E636F6C';
wwv_flow_api.g_varchar2_table(580) := '732C633D622B7061727365496E7428617C7C31293B633D4D6174682E6D696E28632C746869732E6F7074696F6E732E6D61785F636F6C73293B666F722876617220643D622B313B643C3D633B642B2B29666F722876617220653D746869732E726F77733B';
wwv_flow_api.g_varchar2_table(581) := '653E3D313B652D2D29746869732E6164645F666175785F63656C6C28652C64293B72657475726E20746869732E636F6C733D632C746869732E6F7074696F6E732E6175746F67656E65726174655F7374796C6573686565742626746869732E67656E6572';
wwv_flow_api.g_varchar2_table(582) := '6174655F7374796C65736865657428292C746869737D2C682E726563616C63756C6174655F666175785F677269643D66756E6374696F6E28297B76617220623D746869732E24777261707065722E776964746828293B72657475726E20746869732E6261';
wwv_flow_api.g_varchar2_table(583) := '7365583D28662E776964746828292D62292F322C746869732E62617365593D746869732E24777261707065722E6F666673657428292E746F702C2272656C6174697665223D3D3D746869732E24777261707065722E6373732822706F736974696F6E2229';
wwv_flow_api.g_varchar2_table(584) := '262628746869732E62617365583D746869732E62617365593D30292C612E6561636828746869732E666175785F677269642C612E70726F78792866756E6374696F6E28612C62297B746869732E666175785F677269645B615D3D622E757064617465287B';
wwv_flow_api.g_varchar2_table(585) := '6C6566743A746869732E62617365582B28622E646174612E636F6C2D31292A746869732E6D696E5F7769646765745F77696474682C746F703A746869732E62617365592B28622E646174612E726F772D31292A746869732E6D696E5F7769646765745F68';
wwv_flow_api.g_varchar2_table(586) := '65696768747D297D2C7468697329292C746869732E69735F726573706F6E7369766528292626746869732E726573697A655F726573706F6E736976655F6C61796F757428292C746869732E6F7074696F6E732E63656E7465725F77696467657473262674';
wwv_flow_api.g_varchar2_table(587) := '6869732E63656E7465725F7769646765747328292C746869737D2C682E726573697A655F7769646765745F64696D656E73696F6E733D66756E6374696F6E2862297B72657475726E20622E7769646765745F6D617267696E73262628746869732E6F7074';
wwv_flow_api.g_varchar2_table(588) := '696F6E732E7769646765745F6D617267696E733D622E7769646765745F6D617267696E73292C622E7769646765745F626173655F64696D656E73696F6E73262628746869732E6F7074696F6E732E7769646765745F626173655F64696D656E73696F6E73';
wwv_flow_api.g_varchar2_table(589) := '3D622E7769646765745F626173655F64696D656E73696F6E73292C746869732E6D696E5F7769646765745F77696474683D322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D2B746869732E6F7074696F6E732E7769646765';
wwv_flow_api.g_varchar2_table(590) := '745F626173655F64696D656E73696F6E735B305D2C746869732E6D696E5F7769646765745F6865696768743D322A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D2B746869732E6F7074696F6E732E7769646765745F626173';
wwv_flow_api.g_varchar2_table(591) := '655F64696D656E73696F6E735B315D2C746869732E24776964676574732E6561636828612E70726F78792866756E6374696F6E28622C63297B76617220643D612863293B746869732E726573697A655F7769646765742864297D2C7468697329292C7468';
wwv_flow_api.g_varchar2_table(592) := '69732E67656E65726174655F677269645F616E645F7374796C65736865657428292C746869732E6765745F776964676574735F66726F6D5F444F4D28292C746869732E7365745F646F6D5F677269645F68656967687428292C746869732E7365745F646F';
wwv_flow_api.g_varchar2_table(593) := '6D5F677269645F776964746828292C746869737D2C682E6765745F776964676574735F66726F6D5F444F4D3D66756E6374696F6E28297B76617220623D746869732E24776964676574732E6D617028612E70726F78792866756E6374696F6E28622C6329';
wwv_flow_api.g_varchar2_table(594) := '7B76617220643D612863293B72657475726E20746869732E646F6D5F746F5F636F6F7264732864297D2C7468697329293B72657475726E20623D642E736F72745F62795F726F775F616E645F636F6C5F6173632862292C612862292E6D617028612E7072';
wwv_flow_api.g_varchar2_table(595) := '6F78792866756E6374696F6E28612C62297B72657475726E20746869732E72656769737465725F7769646765742862297C7C6E756C6C7D2C7468697329292E6C656E6774682626746869732E24656C2E74726967676572282267726964737465723A706F';
wwv_flow_api.g_varchar2_table(596) := '736974696F6E736368616E67656422292C746869737D2C682E6765745F6E756D5F776964676574733D66756E6374696F6E28297B72657475726E20746869732E24776964676574732E6C656E6774687D2C682E7365745F6E756D5F636F6C756D6E733D66';
wwv_flow_api.g_varchar2_table(597) := '756E6374696F6E2862297B76617220633D746869732E6F7074696F6E732E6D61785F636F6C732C643D4D6174682E666C6F6F7228622F28746869732E6D696E5F7769646765745F77696474682B746869732E6F7074696F6E732E7769646765745F6D6172';
wwv_flow_api.g_varchar2_table(598) := '67696E735B305D29292B746869732E6F7074696F6E732E65787472615F636F6C732C653D746869732E24776964676574732E6D61702866756E6374696F6E28297B72657475726E20612874686973292E617474722822646174612D636F6C22297D292E67';
wwv_flow_api.g_varchar2_table(599) := '657428293B652E6C656E6774687C7C28653D5B305D293B76617220663D4D6174682E6D61782E6170706C79284D6174682C65293B746869732E636F6C733D4D6174682E6D617828662C642C746869732E6F7074696F6E732E6D696E5F636F6C73292C6321';
wwv_flow_api.g_varchar2_table(600) := '3D3D312F302626633E3D662626633C746869732E636F6C73262628746869732E636F6C733D63292C746869732E647261675F6170692626746869732E647261675F6170692E7365745F6C696D69747328746869732E636F6C732A746869732E6D696E5F77';
wwv_flow_api.g_varchar2_table(601) := '69646765745F77696474682B28746869732E636F6C732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B305D297D2C682E7365745F6E65775F6E756D5F726F77733D66756E6374696F6E2862297B76617220633D74686973';
wwv_flow_api.g_varchar2_table(602) := '2E6F7074696F6E732E6D61785F726F77732C643D746869732E24776964676574732E6D61702866756E6374696F6E28297B72657475726E20612874686973292E617474722822646174612D726F7722297D292E67657428293B642E6C656E6774687C7C28';
wwv_flow_api.g_varchar2_table(603) := '643D5B305D293B76617220653D4D6174682E6D61782E6170706C79284D6174682C64293B746869732E726F77733D4D6174682E6D617828652C622C746869732E6F7074696F6E732E6D696E5F726F7773292C63213D3D312F30262628633C657C7C633C74';
wwv_flow_api.g_varchar2_table(604) := '6869732E726F777329262628633D746869732E726F7773292C746869732E6D696E5F726F77733D652C746869732E6D61785F726F77733D632C746869732E6F7074696F6E732E6D61785F726F77733D633B76617220663D746869732E726F77732A746869';
wwv_flow_api.g_varchar2_table(605) := '732E6D696E5F7769646765745F6865696768742B28746869732E726F77732B31292A746869732E6F7074696F6E732E7769646765745F6D617267696E735B315D3B746869732E647261675F617069262628746869732E647261675F6170692E6F7074696F';
wwv_flow_api.g_varchar2_table(606) := '6E732E636F6E7461696E65725F6865696768743D66292C746869732E636F6E7461696E65725F6865696768743D662C746869732E67656E65726174655F666175785F6772696428746869732E726F77732C746869732E636F6C73297D2C682E67656E6572';
wwv_flow_api.g_varchar2_table(607) := '6174655F677269645F616E645F7374796C6573686565743D66756E6374696F6E28297B76617220623D746869732E24777261707065722E776964746828293B746869732E7365745F6E756D5F636F6C756D6E732862293B76617220633D746869732E6F70';
wwv_flow_api.g_varchar2_table(608) := '74696F6E732E65787472615F726F77733B72657475726E20746869732E24776964676574732E656163682866756E6374696F6E28622C64297B632B3D2B612864292E617474722822646174612D73697A657922297D292C746869732E726F77733D746869';
wwv_flow_api.g_varchar2_table(609) := '732E6F7074696F6E732E6D61785F726F77732C746869732E62617365583D28662E776964746828292D62292F322C746869732E62617365593D746869732E24777261707065722E6F666673657428292E746F702C746869732E6F7074696F6E732E617574';
wwv_flow_api.g_varchar2_table(610) := '6F67656E65726174655F7374796C6573686565742626746869732E67656E65726174655F7374796C65736865657428292C746869732E67656E65726174655F666175785F6772696428746869732E726F77732C746869732E636F6C73297D2C682E646573';
wwv_flow_api.g_varchar2_table(611) := '74726F793D66756E6374696F6E2862297B72657475726E20746869732E24656C2E72656D6F7665446174612822677269647374657222292C612E6561636828746869732E24776964676574732C66756E6374696F6E28297B612874686973292E72656D6F';
wwv_flow_api.g_varchar2_table(612) := '7665446174612822636F6F72647322297D292C662E756E62696E6428222E677269647374657222292C746869732E647261675F6170692626746869732E647261675F6170692E64657374726F7928292C746869732E726573697A655F6170692626746869';
wwv_flow_api.g_varchar2_table(613) := '732E726573697A655F6170692E64657374726F7928292C746869732E24776964676574732E656163682866756E6374696F6E28622C63297B612863292E636F6F72647328292E64657374726F7928297D292C746869732E726573697A655F617069262674';
wwv_flow_api.g_varchar2_table(614) := '6869732E726573697A655F6170692E64657374726F7928292C746869732E72656D6F76655F7374796C655F7461677328292C622626746869732E24656C2E72656D6F766528292C746869737D2C612E666E2E67726964737465723D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(615) := '62297B72657475726E20746869732E656163682866756E6374696F6E28297B76617220633D612874686973293B632E646174612822677269647374657222297C7C632E6461746128226772696473746572222C6E6577206428746869732C6229297D297D';
wwv_flow_api.g_varchar2_table(616) := '2C647D293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1629846488295803)
,p_plugin_id=>wwv_flow_api.id(1619300593093577)
,p_file_name=>'jquery.dsmorse-gridster.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
