// TODO empty attachment fields when edit
var attachments;
attachments = function() {
    var i = 1;

    $('.add_attachment_input_btn').click(function (e) {
        e.preventDefault();
        var WhichModel = $(this).data('controller');
        if (i <= 10){
            $("#attachments_form_container").append(createForm(WhichModel));
        }else{
            if (i==11){
                $("#attachments_form_container").append("Sorry. You can't add more than 10 attachments.");
            }
        };
        i++;
    });

    var createForm = function(controller){
        var container = document.createElement('div')
        container.class = 'form-group'

        container.innerHTML = '<label for="'+controller+'_attachments_attributes_'+ i +'_file" >File</div> \
    <input type="file" name="'+controller+'[attachments_attributes]['+ i +'][file]" id="'+controller+'_attachments_attributes_' + i +'_file"/>\
      <span class="help-block small">Leave blank if not needed</span>';
        return container
    };

};

$(document).ready(attachments);
$(document).on('page:load', attachments);