function buscarPorID(){
   $("#boton_buscar_user").click(function(){
     var usuario = $("#user_id").val();
     
     $.ajax({
        url: "/users/buscar_por_id/" + usuario,
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




function buscarPorName(){
   $("#boton_buscar_name").click(function(){
     var nombre = $("#name_id").val();
     
     $.ajax({
        url: "/users/buscar_por_name/" + nombre,
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
   buscarPorName();
});

