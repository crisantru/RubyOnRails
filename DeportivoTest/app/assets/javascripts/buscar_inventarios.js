function buscarPorID(){
   $("#boton_buscar_ID").click(function(){
     var id = $("#id_inventario").val();
     
     $.ajax({
        url: "/inventories/buscar_por_id/" + id,
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
              alert("No se encontraron resultados...");
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



function buscarPorSucursal(){
   $("#boton_buscar_sucursal").click(function(){
     var sucursal = $("#branch").val();
     
     $.ajax({
        url: "/inventories/buscar_por_sucursal/" + sucursal,
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
              alert("No se encontraron resultados...");
              $("#respuesta").html("");
              location.reload();

           }
        }
     })
  });
};
$(document).ready(function(){
   buscarPorSucursal();
});


