function modal_open(title, url){
    $("#modal_title").html(title);
	$("#modal_body").html("<div class='overlay' ><i  class='fa fa-refresh fa-spin'  ></i> </div>");


    $("#modal_body").load(url);


    $('#modal_').modal({
      backdrop: 'static',
      keyboard: false
    });

    $("#modal_").modal('show');

    $('.btn_modal_close').attr('onClick', "modal_close()");

  }	

  function modal_close( ){
    $("#modal_").modal('hide');

    $("#modal_body").html('Closing...');


  }


