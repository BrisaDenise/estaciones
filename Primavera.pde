
//Muestra la cortina de Primavera
void cortinaPrimavera()
{
  //Creamos un nuevos objeto de la clase Cortinas para visualizar la cortina de Primavera
  Cortinas primavera = new Cortinas("Primavera");
  primavera.display();
}






//Con esta clase establecemos el comportamiento y visualización de cada flor
class Flor
{
  //Con este método mostraremos la flor que variará de ser un CAPULLO a ser una FLOR (abierta)
  void display()
  {
    //Con el for recorreremos todo el array boolean florecida[] para saber si alguna flor está abierta
    for (int fl = 0; fl < 20; fl++)
    {
      //En el caso de que no lo esté, se visualizará el capullo 
      //Se utiliza el array bidimensional flores[][]
      if (!florecida[fl]) {image(capullo,flores[fl][0],flores[fl][1]);}
      
      //En el caso de que sí lo esté, se visualizará la flor abierta
      else {image(flor,flores[fl][0],flores[fl][1]);}
    }
  }
  
   
  //Este método se utiliza para florecer el capullo
  void florecer()
  {
    //Con este for, recorremos cada una de las posiciones de cada flor
    for (int f = 0; f < 20; f++)
    {
      //Con el siguiente condicional se verifica si la flor se encuentra dentro de la figura del rayo del sol, es decir, del triángulo
      //Para ello se toma el valor de cada uno de sus vértices (x e y)
      //Teniendo en cuenta que desde el vertice inferior rayo_luz[2][x] hasta el vertice superior izquierdo rayo_luz[0][x] hay una distancia de x: +100
      //Y también que desde el vertice inferior rayo_luz[2][x] hasta el vertice superior derecho rayo_luz[1][x] hay una distancia de x: +200
      //Llegué a lo siguiente:
      
      //- Primero: se verifica que desde el vertice inferior del rayo_luz[2][1] hasta la posy de la flor haya más de 300 -> De esta manera podemos ver que la flor queda completamente bañada en la "luz"
      
      //- Después desde la posx de la flor hasta el vertice inferior rayo_luz[2][0] tiene que haber una diferencia mínima de 50 (en el eje x), rayo_luc[2][0] siempre tiene que ser menor -> Esto es debido a que el rayo que se forma está inclinado hacia la derecha
      //- Pero la diferencia puede ser max de 150, es decir que de la posx de la flor, el rayo_luz [2][0] puede estar separado hasta 150px
      
      //- Luego, el vertice superior derecho rayo_luz[1][0] tiene que ser mayor por 75px a la posX de la flor, como mínimo (eje x)
      //- Por último, el vértice superior izquierdo rayo_luz[0][0] debe tener una distancia mínima de 50px con la posX de la flor, siendo rayo_luz[0][0] de menor valor   
      
      //Toda esta serie de condicionales permitirá que siempre que la flor este dentro del triángulo suceda lo siguiente
      if (rayo_luz[2][1] > flores[f][1] + 300 && rayo_luz[2][0] < flores[f][0] - 50 && rayo_luz[2][0] > flores[f][0]- 150 && rayo_luz[1][0] > flores[f][0]+75 && rayo_luz[0][0] < flores[f][0]+50)
      {
        //Si la flor de esa posición no está aún florecida, puede florecer, entonces...
        if(!florecida[f]) 
        {
          //Se pondrá en true abrir_flor que nos permitirá comenzar el proceso de "crecimiento"
          abrir_flor[f]=true;
        }
      }
      
      //En el caso de que el rayo de luz deje de alumbrar la flor
      else
      {
        //Y de que no esté florecida
        if(!florecida[f]) 
        {
          //Abrir_flor será false, es decir se interrupirá su crecimiento
          abrir_flor[f]=false; 
          //Y su tiempo volverá a 0
          tiempos_flores[f] = 0;
        }
      }
      
      
      //Si abrir_flor es true
      if (abrir_flor[f])
          {
            //Se llamará al evento tomarTiempo() que guardará el tiempo transcurrido hasta ese momento en la variable tiempo_actual
            tomarTiempo();
            
            //el tiempo_actual se guardará en el tiempo_flores que corresponde al momento en que empieza a crecer, único para cada flor
            tiempos_flores[f] = tiempo_actual;
           
            //Si el tiempo es mayor al tiempo de la flor + los 4 segundos de retardo
            if (tiempo > tiempos_flores[f]+retardo)
            {
              //Se reproducirá el sonido de la flor abriendose
              mov_flor.trigger();
              
              //bandera volverá a true (correspondiente del evento tomarTiempo())
              bandera=true;  
              //Su boolean de florecida pasará a ser true, y "florecerá"
              florecida[f] =true;
              //Abrir_flor pasa a ser false así detenemos el if y evitamos que el rayo del sol vuelva a afectarla en algo
              abrir_flor[f]=false;
              //Sumamos +1 al contador de flores abiertas
              flores_abiertas++;
            }
      }
    }
  }
}





//Muestra la escena Primavera
void primavera()
{
  //Dibujamos el fondo de primavera
  image(primavera_fondo,0,0,width,height);
  
  //Creamos un objeto de la clase Atajos para hacer uno que nos regrese al menú principal con sus correspondientes métodos
  Atajos volver_menu = new Atajos(20,20,2);
  volver_menu.display();
  volver_menu.menu();
  
  //Creamos otro objeto de la clase Atajos que nos haga uno que nos permita avanzar a la pantalla final
  //Esto es en caso de que no se pueda terminar la escena
  Atajos avanzar = new Atajos(width*0.965,20,1);
  avanzar.display();
  avanzar.accion();
  
  //Creamos un objeto de la clase Frase para escribir la frase "acertijo" correspondiente a la escena y la mostramos
  Frase f_primavera = new Frase ("... resistiendo en calma,", "lo bello resurgirá ...");
  f_primavera.display();
  
  
  
  //Creamos el array de capullos de 20 flores
  Flor [] capullos = new Flor [20];
  
  //Con un for recorremos cada capullo para crearlo y asignarle sus métodos
  for (int i=0; i<20;i++)
  {
    capullos[i] = new Flor();
    capullos[i].display();
    capullos[i].florecer();
  }
  
  
  //Con este condicional, loq ue logramos es que el usuario tenga que mantener el click apretado para poder florecer la flor
  //Además de que, como explicamos antes, tendrá que esperar 4 segundos
  
  //Si el mouse es presionado y mantenido con el botón izquierdo
  if(mousePressed && mouseButton==LEFT)
  {
    //El array bidimensional rayo_luz tomará los siguientes valores
    rayo_luz[0][0]= mouseX + 100;
    rayo_luz[0][1]= 0;
    rayo_luz[1][0]= mouseX + 200;
    rayo_luz[1][1]= 0;
    rayo_luz[2][0]= mouseX;
    rayo_luz[2][1]= mouseY;
    
    
    //Detenemos el contorno
    noStroke();
    //Rellenamos con un amarillo con opacidad para ilustrar un "rayo de sol
    fill(#FFF279, 100);
    //Armamos el triángulo con las medidas de arriba
    triangle(rayo_luz[0][0],rayo_luz[0][1],rayo_luz[1][0],rayo_luz[1][1],rayo_luz[2][0],rayo_luz[2][1]);
    //Detenemos el relleno
    noFill();
  }
  
  //En el caso de que no se cumplan esas dos condiciones, los valores de rayo_luz[][] serán 0
  //Esta es para evitar que cuando se suelte el botón, se queden guardados lo anteriores valores y las flores sigan creciendo
  else 
  {
    rayo_luz[0][0]= 0;
    rayo_luz[0][1]= 0;
    rayo_luz[1][0]= 0;
    rayo_luz[1][1]= 0;
    rayo_luz[2][0]= 0;
    rayo_luz[2][1]= 0;
  }
  
  
  //Una vez que la cantidad de flores abiertas sea igual a 20 (es decir, todas las flores), se pasará a la pantalla final
  if(flores_abiertas==20)
  {
    paso_estacion=true;
  }
  
}
