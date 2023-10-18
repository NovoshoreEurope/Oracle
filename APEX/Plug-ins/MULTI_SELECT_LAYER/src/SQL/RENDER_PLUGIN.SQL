PROCEDURE render_plugin (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result )
AS
    --custom plugin attributes
    l_result                                apex_plugin.t_page_item_render_result;
    l_item_name                             varchar2(1000) := apex_plugin.get_input_name_for_page_item(false);
    l_item_value                            varchar2(1000) := p_param.value;
    --
    attr_label_name                         p_item.attribute_02%TYPE := p_item.attribute_02;
    attr_label_color                        p_item.attribute_02%TYPE := p_item.attribute_04;
    attr_sql_query                          p_item.attribute_03%TYPE := p_item.attribute_03;
    -- Define variables para almacenar los resultados
    v_identificador                         VARCHAR2(100);
    v_valor                                 VARCHAR2(200);
    v_descripcion                           VARCHAR2(300);
    v_split_values                          apex_t_varchar2;
    v_checkbox_checked                      VARCHAR2(1); -- You can limit it to 'Y' or 'N'
    -- Define un tipo de referencia a cursor
    TYPE ref_cur IS REF CURSOR;
    -- Declara un cursor dinámico
    c ref_cur;
    --
    l_html      varchar(4000);
    --
BEGIN
    --debug
    if apex_application.g_debug then
      apex_plugin_util.debug_page_item(p_plugin, p_item, p_param.value, p_param.is_readonly, p_param.is_printer_friendly);
    end if;
    --
    l_html := '<button class="t-Button t-Button--icon t-Button--large t-Button--primary t-Button--link t-Button--iconRight t-Button--gapTop lto' || p_item.id || '_0" onclick="void(0);" type="button" id="b-data-multiselect-info">
                <span class="t-Icon t-Icon--left fa fa-angle-down" aria-hidden="true"></span>';
    if attr_label_color is null then
        l_html := l_html || '<span class="t-Button-label">' || attr_label_name || '</span>';
        l_html := l_html || '<span class="t-Icon t-Icon--right fa fa-angle-down" aria-hidden="true"></span></button>';
    else
        l_html := l_html || '<span class="t-Button-label" style="color:' || attr_label_color || '">' || attr_label_name || '</span>';
        l_html := l_html || '<span class="t-Icon t-Icon--right fa fa-angle-down" style="color:' || attr_label_color || '" aria-hidden="true"></span></button>';
    end if;
    --
    l_html :=  l_html || '<div id="data-multiselect-info" class="checkbox-layer"><ul>';
    -- Abre el cursor dinámico con la consulta SQL
    OPEN c FOR attr_sql_query;
    -- Bucle para leer todos los registros del cursor
    LOOP
        -- Obtiene el siguiente registro del cursor
        FETCH c INTO v_identificador, v_valor, v_descripcion;
            -- Sale del bucle si no hay más registros
        EXIT WHEN c%NOTFOUND;
            -- Split l_item_value by '@' delimiter
            v_split_values := apex_string.split(l_item_value, '@');
            -- Initialize a variable to track if the checkbox should be checked
            v_checkbox_checked := 'N';
            -- Check if v_valor is in the split values
            FOR i IN 1..v_split_values.COUNT LOOP
                IF v_valor = v_split_values(i) THEN
                    v_checkbox_checked := 'Y';
                    EXIT; -- No need to continue checking if found
                END IF;
            END LOOP;
            --
            l_html :=  l_html || '<li class="no-sign">';
            l_html :=  l_html || '<label>';
            l_html := l_html || '<input name="' || v_identificador || '_li" type="checkbox" value="' || v_valor || '"';
            -- If v_checkbox_checked is 'Y', add the "checked" attribute
            IF v_checkbox_checked = 'Y' THEN
                l_html := l_html || ' checked="checked"';
            END IF;
            l_html := l_html || '>';
            l_html := l_html || '&nbsp;&nbsp;' || v_valor;
            l_html :=  l_html || '</label>';
            l_html :=  l_html || '<button class="uxxi-t-form-help-button js-itemHelp" tabindex="-1" type="button" title="' || v_descripcion || '" aria-label="' || v_descripcion || '"><span class="a-Icon fa fa-info-circle-o" aria-hidden="true" style="color:darkblue; padding-top: 3px;"></span></button>';
            l_html :=  l_html || '</li>';
    END LOOP;
    --
    l_html :=  l_html || '</ul><input id="' || l_item_name || '" name="' || l_item_name || '" value="'||l_item_value||'" type="hidden"></div>';
    -- Cierra el cursor
    CLOSE c;
    --
    htp.p(l_html);
    --
    apex_javascript.add_onload_code(p_code => 'multiSelectWindow._initialize("'||l_item_name||'", "'||l_item_value||'");');
    --
end render_plugin;