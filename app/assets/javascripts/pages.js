var Form = {
  polling: false,
  check : function(request_id) {
    $.post('register_check', { request_id: request_id }, function(response) {
      status = response.status;

      if (status == 'complete') {
        $('#form-submit').prop('disabled', false);
      }
      else {
        setTimeout(function () { Form.check(request_id) }, 2000);
      }
    });
  },
  init : function () {
    $('form#register-form').bind('ajax:before', function(evt, data, status, xhr){
      $('#form-submit').prop('disabled', true);
    })

    $('form#register-form').bind('ajax:success', function(evt, data, status, xhr){
      Form.check(data.request_id);
    })
  }
}

$(document).ready(function() {
  Form.init();
});
