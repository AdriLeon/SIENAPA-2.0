$(".admin").on("click", function () {
  $('.admin').addClass("active");
  $('.operador').removeClass("active");
  var valorBoton = $(this).val();
  $('#boton-valor').val(valorBoton);
});
$(".operador").on("click", function () {
  $('.operador').addClass("active");
  $('.admin').removeClass("active");
  var valorBoton = $(this).val(); // Capturar el valor del botón
  $('#boton-valor').val(valorBoton); // Actualizar el campo oculto del formulario
});
$('.open-btn').click(function () {
  $('.sidebar').addClass('active');
});
$('.close-btn').click(function () {
  $('.sidebar').removeClass('active');
});
$("#selectUsuario").on("change", function () {
  var selectedOption = $(this).children("option:selected");
  var optionId = selectedOption.attr("id");
  var optionValue = selectedOption.attr("class");
  $('#select-valor').val(optionValue);
  $('#no_control').val(optionId);
  if ($(this).val() == "administrador") {
    $('.admin').addClass("active");
    $('.operador').removeClass("active");
    var valorBoton = $(this).val();
    $('#boton-valor').val(valorBoton);
  }
  if ($(this).val() == "operador") {
    $('.operador').addClass("active");
    $('.admin').removeClass("active");
    var valorBoton = $(this).val();
    $('#boton-valor').val(valorBoton);
  }
});
$('#selectPozo').on('change', function () {
  var selectedOption = $(this).children("option:selected");
  var optionValue = selectedOption.attr("class");
  $('#horario').text(optionValue);
});
$('#btn_flip').click(function () {
  $(this).$('.flip-card').addClass('flipped');
});
$('#btn_flip2').click(function () {
  $(this).$('.flip-card').removeClass('flipped');
});