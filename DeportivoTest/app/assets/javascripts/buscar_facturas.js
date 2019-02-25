function buscarPorFecha(){
   $("#boton_buscar_fecha").click(function(){
     var fecha = $("#fecha").val();
     
     $.ajax({
        url: "/bills/buscar_por_fecha/" + fecha,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta").html("Cargando...");
        },
        error: function(){
           $("#respuesta").html("Error al intentar buscar el empleado. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              alert("No existen facturas para la fecha especificada");
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

function buscarPorCliente(){
   $("#boton_buscar_cliente").click(function(){
     var cliente = $("#cliente").val();
     
     $.ajax({
        url: "/bills/buscar_por_cliente/" + cliente,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta").html("Cargando...");
        },
        error: function(){
           $("#respuesta").html("Error al intentar buscar el empleado. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              alert("El cliente no cuenta con facturas");
              $("#respuesta").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorCliente();
});