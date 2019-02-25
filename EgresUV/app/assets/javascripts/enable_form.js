$(function () {
          var $checkbox = $('[id^="enableEgresado"]'),
          	  $checkbox2 = $('[id^="enableAcademico"]'),
              $field = $('#type_field');
              $field2 = $('#type_field2');
              $field3 = $('#type_field3');
              $field4 = $('#type_field4');
              $field5 = $('#user_empleo');
              $field6 = $('#type_field6');
              $field7 = $('#user_areaTrabajo');
              $field8 = $('#type_field8');
              $field9 = $('#type_field9');
              $field10 = $('#type_field10');
              $field11 = $('#type_field11');
              $field12 = $('#type_field12');



          $checkbox.change(function (e) {
              
              $field.prop('disabled', !$checkbox.is(':checked'))
              $field2.prop('disabled', !$checkbox.is(':checked'))
              $field3.prop('disabled', !$checkbox.is(':checked'))
              $field4.prop('disabled', !$checkbox.is(':checked'))
              $field5.prop('disabled', !$checkbox.is(':checked'))
              $field6.prop('disabled', !$checkbox.is(':checked'))
              $field7.prop('disabled', !$checkbox.is(':checked'))
              $field8.prop('disabled', !$checkbox.is(':checked'))
          });

          $checkbox2.change(function (e) {
              
              $field9.prop('disabled', !$checkbox2.is(':checked'))
              $field10.prop('disabled', !$checkbox2.is(':checked'))
              $field11.prop('disabled', !$checkbox2.is(':checked'))
              $field12.prop('disabled', !$checkbox2.is(':checked'))
              
          });


      });

/*function openPopup(link)
{
    link.hide();
    window.open(link.href,'exam_dialog','toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=no');
    return false;
}*/
