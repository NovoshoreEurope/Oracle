prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.5'
,p_default_workspace_id=>7337444115725827
,p_default_application_id=>115
,p_default_id_offset=>0
,p_default_owner=>'WKSP_JUANANTONIO'
);
end;
/
 
prompt APPLICATION 115 - PLUGIN ARENA
--
-- Application Export:
--   Application:     115
--   Name:            PLUGIN ARENA
--   Date and Time:   13:19 Tuesday October 17, 2023
--   Exported By:     JUANANTONIO
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 19783941033239815
--   Manifest End
--   Version:         23.1.5
--   Instance ID:     7330142950308600
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/multi_select_window
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(19783941033239815)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'MULTI_SELECT_WINDOW'
,p_display_name=>'MultiSelectWindow 0.6.1'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#ns.common.js',
'#PLUGIN_FILES#ns.plugin.js'))
,p_css_file_urls=>'#PLUGIN_FILES#ns.plugin.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE render_plugin (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result )',
'AS',
'    --custom plugin attributes',
'    l_result                                apex_plugin.t_page_item_render_result;',
'    l_item_name                             varchar2(1000) := apex_plugin.get_input_name_for_page_item(false);',
'    l_item_value                            varchar2(1000) := p_param.value;',
'    --',
'    attr_label_name                         p_item.attribute_02%TYPE := p_item.attribute_02;',
'    attr_label_color                        p_item.attribute_02%TYPE := p_item.attribute_04;',
'    attr_sql_query                          p_item.attribute_03%TYPE := p_item.attribute_03;',
'    -- Define variables para almacenar los resultados',
'    v_identificador                         VARCHAR2(100);',
'    v_valor                                 VARCHAR2(200);',
'    v_descripcion                           VARCHAR2(300);',
'    v_split_values                          apex_t_varchar2;',
'    v_checkbox_checked                      VARCHAR2(1); -- You can limit it to ''Y'' or ''N''',
'    -- Define un tipo de referencia a cursor',
'    TYPE ref_cur IS REF CURSOR;',
unistr('    -- Declara un cursor din\00E1mico'),
'    c ref_cur;',
'    --',
'    l_html      varchar(4000);',
'    --',
'BEGIN',
'    --debug',
'    if apex_application.g_debug then',
'      apex_plugin_util.debug_page_item(p_plugin, p_item, p_param.value, p_param.is_readonly, p_param.is_printer_friendly);',
'    end if;',
'    --',
'    l_html := ''<button class="t-Button t-Button--icon t-Button--large t-Button--primary t-Button--link t-Button--iconRight t-Button--gapTop lto'' || p_item.id || ''_0" onclick="void(0);" type="button" id="b-data-multiselect-info">',
'                <span class="t-Icon t-Icon--left fa fa-angle-down" aria-hidden="true"></span>'';',
'    if attr_label_color is null then',
'        l_html := l_html || ''<span class="t-Button-label">'' || attr_label_name || ''</span>'';',
'        l_html := l_html || ''<span class="t-Icon t-Icon--right fa fa-angle-down" aria-hidden="true"></span></button>'';',
'    else',
'        l_html := l_html || ''<span class="t-Button-label" style="color:'' || attr_label_color || ''">'' || attr_label_name || ''</span>'';',
'        l_html := l_html || ''<span class="t-Icon t-Icon--right fa fa-angle-down" style="color:'' || attr_label_color || ''" aria-hidden="true"></span></button>'';',
'    end if;',
'    --',
'    l_html :=  l_html || ''<div id="data-multiselect-info" class="checkbox-layer"><ul>'';',
unistr('    -- Abre el cursor din\00E1mico con la consulta SQL'),
'    OPEN c FOR attr_sql_query;',
'    -- Bucle para leer todos los registros del cursor',
'    LOOP',
'        -- Obtiene el siguiente registro del cursor',
'        FETCH c INTO v_identificador, v_valor, v_descripcion;',
unistr('            -- Sale del bucle si no hay m\00E1s registros'),
'        EXIT WHEN c%NOTFOUND;',
'            -- Split l_item_value by ''@'' delimiter',
'            v_split_values := apex_string.split(l_item_value, ''@'');',
'            -- Initialize a variable to track if the checkbox should be checked',
'            v_checkbox_checked := ''N'';',
'            -- Check if v_valor is in the split values',
'            FOR i IN 1..v_split_values.COUNT LOOP',
'                IF v_valor = v_split_values(i) THEN',
'                    v_checkbox_checked := ''Y'';',
'                    EXIT; -- No need to continue checking if found',
'                END IF;',
'            END LOOP;',
'            --',
'            l_html :=  l_html || ''<li class="no-sign">'';',
'            l_html :=  l_html || ''<label>'';',
'            l_html := l_html || ''<input name="'' || v_identificador || ''_li" type="checkbox" value="'' || v_valor || ''"'';',
'            -- If v_checkbox_checked is ''Y'', add the "checked" attribute',
'            IF v_checkbox_checked = ''Y'' THEN',
'                l_html := l_html || '' checked="checked"'';',
'            END IF;',
'            l_html := l_html || ''>'';',
'            l_html := l_html || ''&nbsp;&nbsp;'' || v_valor;',
'            l_html :=  l_html || ''</label>'';',
'            l_html :=  l_html || ''<button class="uxxi-t-form-help-button js-itemHelp" tabindex="-1" type="button" title="'' || v_descripcion || ''" aria-label="'' || v_descripcion || ''"><span class="a-Icon fa fa-info-circle-o" aria-hidden="true" style="'
||'color:darkblue; padding-top: 3px;"></span></button>'';',
'            l_html :=  l_html || ''</li>'';',
'    END LOOP;',
'    --',
'    l_html :=  l_html || ''</ul><input id="'' || l_item_name || ''" name="'' || l_item_name || ''" value="''||l_item_value||''" type="hidden"></div>'';',
'    -- Cierra el cursor',
'    CLOSE c;',
'    --',
'    htp.p(l_html);',
'    --',
'    apex_javascript.add_onload_code(p_code => ''multiSelectWindow._initialize("''||l_item_name||''", "''||l_item_value||''");'');',
'    --',
'end render_plugin;'))
,p_default_escape_mode=>'HTML'
,p_api_version=>2
,p_render_function=>'render_plugin'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.6.1'
,p_about_url=>'https://www.novoshore.com/'
,p_plugin_comment=>'Introducing a simple yet effective multi-selector component that allows users to conveniently pick multiple items from a list. The user-friendly interface enables item selection by a simple click, with selected items visually highlighted. This basic '
||'version provides a foundation for further customization, offering the ability to select and display chosen items, making it a practical starting point for creating a more robust multi-selector component tailored to your specific project requirements.'
,p_files_version=>147
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(19784779510244376)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_title=>'Attributes'
,p_display_sequence=>0
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(22761330943826069)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_title=>'Sql query'
,p_display_sequence=>1
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20365155202304409)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Label name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>true
,p_attribute_group_id=>wwv_flow_imp.id(19784779510244376)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20367748928424227)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Query'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_sql_min_column_count=>3
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(22761330943826069)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22762970610832826)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Label color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(19784779510244376)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '766172206D756C746953656C65637457696E646F77203D207B0D0A202020202F2F205661726961626C65207061726120616C6D6163656E617220276E616D652720646520666F726D6120616363657369626C652061206F747261732066756E63696F6E65';
wwv_flow_imp.g_varchar2_table(2) := '730D0A202020206E616D653A206E756C6C2C0D0A0D0A202020205F696E697469616C697A653A2066756E6374696F6E2028696E69744E616D652C20696E697456616C75657329207B0D0A20202020202020202275736520737472696374223B0D0A0D0A20';
wwv_flow_imp.g_varchar2_table(3) := '202020202020202F2F2041646420616E206576656E742068616E646C657220746F2074686520627574746F6E0D0A202020202020202024282223622D646174612D6D756C746973656C6563742D696E666F22292E6F6E2822636C69636B222C2066756E63';
wwv_flow_imp.g_varchar2_table(4) := '74696F6E202829207B0D0A20202020202020202020202024282223646174612D6D756C746973656C6563742D696E666F22292E736C696465546F67676C6528293B0D0A2020202020202020202020206368616E6765427574746F6E49636F6E28293B0D0A';
wwv_flow_imp.g_varchar2_table(5) := '20202020202020207D293B0D0A0D0A20202020202020202F2F2041646420616E206576656E742068616E646C657220666F7220636865636B626F78207374617465206368616E6765730D0A202020202020202024282723646174612D6D756C746973656C';
wwv_flow_imp.g_varchar2_table(6) := '6563742D696E666F20696E7075745B747970653D22636865636B626F78225D27292E6F6E28276368616E6765272C2066756E6374696F6E202829207B0D0A2020202020202020202020202F2F2046696C74657220636865636B656420636865636B626F78';
wwv_flow_imp.g_varchar2_table(7) := '657320616E64206765742074686569722076616C7565730D0A2020202020202020202020207661722073656C656374656456616C756573203D2024282723646174612D6D756C746973656C6563742D696E666F20696E7075745B747970653D2263686563';
wwv_flow_imp.g_varchar2_table(8) := '6B626F78225D3A636865636B656427292E6D61702866756E6374696F6E202829207B0D0A2020202020202020202020202020202072657475726E20242874686973292E76616C28293B0D0A2020202020202020202020207D292E67657428293B0D0A0D0A';
wwv_flow_imp.g_varchar2_table(9) := '2020202020202020202020202F2F2053746F7265207468652073656C65637465642076616C75657320736F6D6577686572652077697468207468652070726F766964656420276E616D65270D0A202020202020202020202020247328696E69744E616D65';
wwv_flow_imp.g_varchar2_table(10) := '2C2073656C656374656456616C7565732E6A6F696E28656E756D5F737472696E67732E41525241595F534550415241544F5229293B0D0A20202020202020207D293B0D0A0D0A20202020202020202F2F204368616E67652074686520627574746F6E2069';
wwv_flow_imp.g_varchar2_table(11) := '636F6E206F6E20636C69636B0D0A202020202020202066756E6374696F6E206368616E6765427574746F6E49636F6E2829207B0D0A2020202020202020202020206C65742024627574746F6E203D2024282223622D646174612D6D756C746973656C6563';
wwv_flow_imp.g_varchar2_table(12) := '742D696E666F202E742D49636F6E22293B0D0A20202020202020202020202024627574746F6E2E746F67676C65436C617373282266612D616E676C652D75702066612D616E676C652D646F776E22293B0D0A20202020202020207D0D0A202020207D2C0D';
wwv_flow_imp.g_varchar2_table(13) := '0A0D0A2020202076616C75653A2066756E6374696F6E202829207B0D0A202020202020202072657475726E20247628746869732E6E616D65293B0D0A202020207D2C0D0A0D0A2020202076616C7565417341727261793A2066756E6374696F6E20282920';
wwv_flow_imp.g_varchar2_table(14) := '7B0D0A2020202020202020747279207B0D0A20202020202020202020202072657475726E20247628746869732E6E616D65292E73706C697428656E756D5F737472696E67732E41525241595F534550415241544F52293B0D0A20202020202020207D2063';
wwv_flow_imp.g_varchar2_table(15) := '6174636820286572726F7229207B0D0A2020202020202020202020206D6F73747261724572726F7247656E657269636F28224D756C746953656C65637457696E646F77206572726F723A2022202B206572726F722E6D657373616765293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(16) := '202020207D0D0A202020207D0D0A7D3B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20370313238735819)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.plugin.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6E6F2D7369676E207B0D0A20206C6973742D7374796C652D747970653A206E6F6E653B0D0A202070616464696E672D626F74746F6D3A203570783B0D0A7D0D0A2E636865636B626F782D6C61796572207B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_imp.g_varchar2_table(2) := '6F723A20236639663966393B0D0A20206F766572666C6F773A206175746F3B0D0A20206865696768743A206175746F3B0D0A20206D61782D6865696768743A2033353070783B0D0A2020666C65783A20313030253B0D0A202077686974652D7370616365';
wwv_flow_imp.g_varchar2_table(3) := '3A206E6F726D616C3B0D0A2020646973706C61793A206E6F6E653B0D0A20206F75746C696E653A206E6F6E653B0D0A7D0D0A0D0A2E636865636B626F782D6C61796572206C6162656C207B0D0A2020666F6E742D7765696768743A206E6F726D616C3B0D';
wwv_flow_imp.g_varchar2_table(4) := '0A2020636F6C6F723A20233333333B0D0A7D0D0A0D0A2E636865636B626F782D6C6179657220627574746F6E207B0D0A2020666F6E742D7765696768743A206E6F726D616C3B0D0A20206261636B67726F756E643A2077686974653B0D0A2020626F7264';
wwv_flow_imp.g_varchar2_table(5) := '65723A203070783B0D0A7D0D0A0D0A23622D646174612D6D756C746973656C6563742D696E666F207B0D0A202020206F75746C696E653A206E6F6E653B0D0A7D0D0A0D0A23622D646174612D6D756C746973656C6563742D696E666F3A666F637573207B';
wwv_flow_imp.g_varchar2_table(6) := '0D0A202020206F75746C696E653A206E6F6E653B0D0A7D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20372303257784397)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.plugin.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2F20456E756D730D0A636F6E737420617065785F6D657373616765735F74797065203D207B0D0A202020204552524F523A20276572726F72270D0A7D3B0D0A0D0A636F6E737420617065785F6D657373616765735F6C6F636174696F6E203D207B0D0A';
wwv_flow_imp.g_varchar2_table(2) := '20202020504147453A202770616765270D0A7D3B0D0A0D0A636F6E737420656E756D5F737472696E6773203D207B0D0A2020202041525241595F534550415241544F523A202740272C0D0A20202020424C414E4B5F53504143453A202720272C0D0A2020';
wwv_flow_imp.g_varchar2_table(3) := '2020434F4D4D413A20272C272C0D0A20202020444153483A20272D272C0D0A20202020444154455F534550415241544F523A20272F272C0D0A20202020444F543A20272E272C0D0A20202020444F55424C455F534550415241544F523A20277C7C272C0D';
wwv_flow_imp.g_varchar2_table(4) := '0A20202020454D5054593A2027272C0D0A2020202053454D49434F4C4F4E3A20273B270D0A7D3B0D0A0D0A636F6E737420656E756D5F7472616365203D207B0D0A202020204F4E3A20274F4E272C0D0A202020204F46463A20274F4646270D0A7D3B0D0A';
wwv_flow_imp.g_varchar2_table(5) := '0D0A2F2F0D0A66756E6374696F6E206D6F73747261724572726F7247656E657269636F286D65737361676529207B0D0A20202020617065782E6D6573736167652E73686F774572726F7273285B0D0A20202020202020207B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(6) := '2020747970653A20617065785F6D657373616765735F747970652E4552524F522C0D0A2020202020202020202020206C6F636174696F6E3A20617065785F6D657373616765735F6C6F636174696F6E2E504147452C0D0A2020202020202020202020206D';
wwv_flow_imp.g_varchar2_table(7) := '6573736167653A206D6573736167652C0D0A202020202020202020202020756E736166653A2066616C73652C0D0A20202020202020207D2C0D0A202020205D293B0D0A7D0D0A0D0A66756E6374696F6E206D6F7374726172457869746F47656E65726963';
wwv_flow_imp.g_varchar2_table(8) := '6F286D65737361676529207B0D0A20202020617065782E6D6573736167652E73686F775061676553756363657373286D657373616765293B0D0A7D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(21172020090558628)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.common.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '636F6E737420617065785F6D657373616765735F747970653D7B4552524F523A226572726F72227D2C617065785F6D657373616765735F6C6F636174696F6E3D7B504147453A2270616765227D2C656E756D5F737472696E67733D7B41525241595F5345';
wwv_flow_imp.g_varchar2_table(2) := '50415241544F523A2240222C424C414E4B5F53504143453A2220222C434F4D4D413A222C222C444153483A222D222C444154455F534550415241544F523A222F222C444F543A222E222C444F55424C455F534550415241544F523A227C7C222C454D5054';
wwv_flow_imp.g_varchar2_table(3) := '593A22222C53454D49434F4C4F4E3A223B227D2C656E756D5F74726163653D7B4F4E3A224F4E222C4F46463A224F4646227D3B66756E6374696F6E206D6F73747261724572726F7247656E657269636F2865297B617065782E6D6573736167652E73686F';
wwv_flow_imp.g_varchar2_table(4) := '774572726F7273285B7B747970653A617065785F6D657373616765735F747970652E4552524F522C6C6F636174696F6E3A617065785F6D657373616765735F6C6F636174696F6E2E504147452C6D6573736167653A652C756E736166653A21317D5D297D';
wwv_flow_imp.g_varchar2_table(5) := '66756E6374696F6E206D6F7374726172457869746F47656E657269636F2865297B617065782E6D6573736167652E73686F7750616765537563636573732865297D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(21198293541012398)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.common.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '766172206D756C746953656C65637457696E646F773D7B6E616D653A6E756C6C2C5F696E697469616C697A653A66756E6374696F6E28742C65297B2275736520737472696374223B24282223622D646174612D6D756C746973656C6563742D696E666F22';
wwv_flow_imp.g_varchar2_table(2) := '292E6F6E2822636C69636B222C2866756E6374696F6E28297B24282223646174612D6D756C746973656C6563742D696E666F22292E736C696465546F67676C6528292C24282223622D646174612D6D756C746973656C6563742D696E666F202E742D4963';
wwv_flow_imp.g_varchar2_table(3) := '6F6E22292E746F67676C65436C617373282266612D616E676C652D75702066612D616E676C652D646F776E22297D29292C24282723646174612D6D756C746973656C6563742D696E666F20696E7075745B747970653D22636865636B626F78225D27292E';
wwv_flow_imp.g_varchar2_table(4) := '6F6E28226368616E6765222C2866756E6374696F6E28297B76617220653D24282723646174612D6D756C746973656C6563742D696E666F20696E7075745B747970653D22636865636B626F78225D3A636865636B656427292E6D6170282866756E637469';
wwv_flow_imp.g_varchar2_table(5) := '6F6E28297B72657475726E20242874686973292E76616C28297D29292E67657428293B247328742C652E6A6F696E28656E756D5F737472696E67732E41525241595F534550415241544F5229297D29297D2C76616C75653A66756E6374696F6E28297B72';
wwv_flow_imp.g_varchar2_table(6) := '657475726E20247628746869732E6E616D65297D2C76616C7565417341727261793A66756E6374696F6E28297B7472797B72657475726E20247628746869732E6E616D65292E73706C697428656E756D5F737472696E67732E41525241595F5345504152';
wwv_flow_imp.g_varchar2_table(7) := '41544F52297D63617463682874297B6D6F73747261724572726F7247656E657269636F28224D756C746953656C65637457696E646F77206572726F723A20222B742E6D657373616765297D7D7D3B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(22750991302678071)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.plugin.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6E6F2D7369676E7B6C6973742D7374796C652D747970653A6E6F6E653B70616464696E672D626F74746F6D3A3570787D2E636865636B626F782D6C617965727B6261636B67726F756E642D636F6C6F723A236639663966393B6F766572666C6F773A61';
wwv_flow_imp.g_varchar2_table(2) := '75746F3B6865696768743A6175746F3B6D61782D6865696768743A33353070783B666C65783A313030253B77686974652D73706163653A6E6F726D616C3B646973706C61793A6E6F6E653B6F75746C696E653A307D2E636865636B626F782D6C61796572';
wwv_flow_imp.g_varchar2_table(3) := '206C6162656C7B666F6E742D7765696768743A3430303B636F6C6F723A233333337D2E636865636B626F782D6C6179657220627574746F6E7B666F6E742D7765696768743A3430303B6261636B67726F756E643A236666663B626F726465723A307D2362';
wwv_flow_imp.g_varchar2_table(4) := '2D646174612D6D756C746973656C6563742D696E666F7B6F75746C696E653A307D23622D646174612D6D756C746973656C6563742D696E666F3A666F6375737B6F75746C696E653A307D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(22760477083803423)
,p_plugin_id=>wwv_flow_imp.id(19783941033239815)
,p_file_name=>'ns.plugin.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
