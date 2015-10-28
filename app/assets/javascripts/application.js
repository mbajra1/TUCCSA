// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require_tree .

$(document).ready(
    function(){
        $('input:file').change(

            function(){
                if ($(this).val()) {
                    //window.alert("Changed");
                    $('input:submit').attr('disabled',false);
                    // or, as has been pointed out elsewhere:
                    // $('input:submit').removeAttr('disabled');
                }
            }
        );
    });

function validateCheckbox()
{
    if(!$('#cs_application_is_citizen').attr('checked')){
       // window.alert("you have to accept the terms first");
        $('span .help-inline').html("you have to accept the terms first");
    }
}
$(".alert-message").alert()
$(".alert-message").alert('close')
