function buscarPorFecha(){
   $("#boton_buscar_fecha").click(function(){
     var fecha = $("#fecha").val();
     
     $.ajax({
        url: "/orders/buscar_por_fecha/" + fecha,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta").html("Cargando...");
        },
        error: function(){
           $("#respuesta").html("Error al intentar buscar la fecha solicitada. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              alert("No existen una compra para esa fecha");
              $("#respuesta").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorFecha();
});

function buscarPorAlmacen(){
   $("#boton_buscar_almacen").click(function(){
     var almacen = $("#almacen").val();
     
     $.ajax({
        url: "/orders/buscar_por_almacen/" + almacen,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta").html("Cargando...");
        },
        error: function(){
           $("#respuesta").html("Error al intentar buscar la compra. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              alert("No existen una compra para ese almacen");
              $("#respuesta").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorAlmacen();
});
