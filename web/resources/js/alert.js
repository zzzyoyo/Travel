function alertSuccess(information) {
    $("#mySuccessInformation").remove();
    $("body").append('<div class="alert alert-success alert-dismissible" role="alert" id="mySuccessInformation">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button> <strong>Success!</strong> '+ information +'</div>');
}
function alertError(information) {
    $("#myErrorInformation").remove();
    $("body").append('<div class="alert alert-danger alert-dismissible" role="alert" id="myErrorInformation">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button> <strong>Error!</strong> '+ information +'</div>');
}
function alertInfo(information) {
    $("#myInfoInformation").remove();
    $("body").append('<div class="alert alert-info alert-dismissible" role="alert" id="myInfoInformation">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button> <strong>Heads up!</strong> '+ information +'</div>');
}