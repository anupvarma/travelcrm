<%def name="passports_selector(name='passport_id', values=[], can_edit=True)">
    <%
        _func_id = h.common.gen_id()
        _id = h.common.gen_id()
        _storage_id = h.common.gen_id()
        _tb_id = "tb-%s" % _id
    %>
    % if can_edit:
    <script type="text/javascript">
        function add_${_func_id}(id){
            if(is_int(id)){
                var input = $('<input type="hidden" name="${name}">').val(id);
                input.appendTo('#${_storage_id}');
            }
            return false;
        }
        function delete_${_func_id}(grid_id){
            var rows = get_checked($('#' + grid_id));
            if(rows.length > 0){
                $.each(rows, function(i, row){
                    $('#${_storage_id} input[name=${name}][value=' + row.id + ']').remove();
                });
                $('#' + grid_id).datagrid('reload');
            }
            return false;
        }
    </script>
    % endif
    <table class="easyui-datagrid"
        id="${_id}"
        data-options="
            url:'/passports/list',border:false,
            fit:true,singleSelect:true,
            rownumbers:true,sortName:'id',sortOrder:'desc',
            idField:'_id',checkOnSelect:false,
            selectOnCheck:false,toolbar:'#${_tb_id}',
            onBeforeLoad: function(param){
                var response = $(this).data('response');
                if(response !== ''){
                    add_${_func_id}(response);
                    $(this).data('response', '');
                }
                var id = [0];
                $.each($('#${_storage_id} input[name=${name}]'), function(i, el){
                    id.push($(el).val());
                });
                param.id = id.join();                            
                param.rows = 0;
                param.page = 0;
            }
        " width="100%">
        <thead>
            % if can_edit:
                <th data-options="field:'_id',checkbox:true">${_(u"id")}</th>
            % endif
            <th data-options="field:'id',sortable:true,width:60">${_(u"id")}</th>
            <th data-options="field:'passport_num',sortable:true,width:200">${_(u"passport num")}</th>
            <th data-options="field:'passport_type',sortable:true,width:100">${_(u"type")}</th>
            <th data-options="field:'end_date',width:80">${_(u"end date")}</th>
            <th data-options="field:'modifydt',sortable:true,width:120,styler:function(){return datagrid_resource_cell_styler();}"><strong>${_(u"updated")}</strong></th>
            <th data-options="field:'modifier',width:100,styler:function(){return datagrid_resource_cell_styler();}"><strong>${_(u"modifier")}</strong></th>
        </thead>
    </table>
    <div id="${_storage_id}">
        % for id in values:
            ${h.tags.hidden(name, id)}
        % endfor
    </div>
    % if can_edit:
    <div class="datagrid-toolbar" id="${_tb_id}">
        <div class="actions button-container">
            <%
                f_id = h.common.gen_id()
            %>
            <div class="button-group minor-group">
                <a href="#" class="button _action" 
                    data-options="
                        container:'#${_id}',action:'dialog_open',url:'/passports/add'
                    ">
                    ${_(u"Add")}</a>
                <a href="#" class="button _action" 
                    data-options="
                        container:'#${_id}',action:'dialog_open',url:'/passports/edit',property:'with_row'
                    ">
                    ${_(u"Edit")}</a>
                <a href="#" class="button danger" onclick="delete_${_func_id}('${_id}');">${_(u"Delete")}</a>
            </div>
        </div>
    </div>
    % endif
</%def>
