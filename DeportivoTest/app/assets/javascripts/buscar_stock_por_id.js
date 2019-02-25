function buscarPorID(){
   $("#boton_buscar").click(function(){
     var id = $("#id_stock").val();
     
     $.ajax({
        url: "/stocks/buscar_stock_por_id/" + id,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta").html("Cargando...");
        },
        error: function(){
           $("#respuesta").html("Error al intentar buscar el almacen. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              alert("No existe el almacen");
              $("#respuesta").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorID();
});

function buscarPorDireccion(){
   $("#boton_buscar_direccion").click(function(){
     var address = $("#stock_address").val();
     
     $.ajax({
        url: "/stocks/buscar_stock_por_direccion/" + address,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta_direccion").html("Cargando...");
        },
        error: function(){
           $("#respuesta_direccion").html("Error al intentar buscar el almacen. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              
              alert("No existe el almacen");
              $("#respuesta_direccion").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorDireccion();
});

function buscarPorSucursal(){
   $("#boton_buscar_sucursal").click(function(){
     var branch = $("#branch").val();

     $.ajax({
        url: "/stocks/buscar_stock_por_sucursal/" + branch,
        dataType: "JSON",
        timeout: 10000,
        beforeSend: function(){
           $("#respuesta_sucursal").html("Cargando...");
        },
        error: function(){
           $("#respuesta_sucursal").html("Error al intentar buscar el almacen. Por favor intente más tarde.");
        },
        success: function(res){
           if(res){
              //$("#respuesta").html('<a href="/empleados/'+res.id+'"> '+res.nombre+' ' + res.apellido + ' </a>');
        //$("#respuesta").html('<a href="/empleados/ "> '+res.id+ ' ' +res.nombre+' ' + res.apellido + ' </a>');
              location.reload();
           }else{
              //$("#respuesta").html("El legajo no le pertenece a ningún empleado.");
              
              alert("No existe el almacen");
              $("#respuesta_sucursal").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorSucursal();
});