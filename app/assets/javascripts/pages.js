var Form = {
  polling: false,
  check : function(request_id) {
    $.post('register_check', { request_id: request_id }, function(response) {
      status = response.status;

      if (status == 'complete') {
        $('#form-submit').prop('disabled', false);

        if (response.result != undefined && response.result.error_message != undefined) {
          Form.error_alert(response.result.error_message);
        }
      }
      else {
        setTimeout(function () { Form.check(request_id) }, 2000);
      }
    });
  },
  error_alert : function (message) {
    $('#error-alert').html('<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')
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
