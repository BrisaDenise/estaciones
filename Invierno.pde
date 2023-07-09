
//Muestra la cortina de Invierno
void cortinaInvierno()
{
  //Creamos un nuevos objeto de la clase Cortinas para visualizar la cortina de Invierno
  Cortinas invierno = new Cortinas("Invierno");
  invierno.display();
}





//Con esta clase ubicaremos los cúmulos de nieve pero también controlaremos el comportamiento de las bolas de nieve que "destruirán" a los cúmulos
class Nieve
{
  
  //Con estos float definiremos las posciones x e y de cada cúmulo
  float posx, posy;
  
  //Creamos un contructor para que se puedan cargar las posiciones x e y
  Nieve(float x, float y)
  {
    //Igualamos las variables de constructor a las variables locales
    posx = x;
    posy = y;
  }
  
  //Creamos un método con el cual mostraremos la imagen del cúmulo de nieve en la posición indicada
  void display() {image(cumulo_nieve,posx,posy);}
  
  //Crearemos un método que nos permita tirar una bola de nieve y que destruya el cúmulo de nieve
  void romperNieve()
  {
   
    //Con el siguiente for recorreremos los 17 cúmulos de nieve
    for(int i=0; i<17;i++)
    {
      
      //Preguntaremos si no están "explotados"
      //Si no lo están, eso significan que todavía se pueden destruir
      if (!explotarNieve[i])
      {
        //Si su tirarNieve es true; es decir, que se clickeo sobre ese cúmulo, entonces...
        if (tirarNieve[i])
        {
          
          //La posición Y de su bola de nieve irá aumentando 0.8 en cada frame, lo que hará que se la vea cayendo  
          bola_posY[i]+=0.8;  
          //Y se actualizará su posición redibujando la imagen, con la nueva posición Y pero manteniendo su posición X (es decir, la obtenida de mouseX)
          image(bola_nieve, bola_posx[i], bola_posY[i]);
          
          //Si la posición Y de la bola de nieve es mayor a la posición del cúmulo
          //Es decir, si impacta contra este
          if (bola_posY [i]> pos_cumulo[i][1])
          {
            //Sonará el sampler del impacto contra la nieve
            golpe_nieve.trigger();
            
            //Se pondrá en true explotarNieve lo que producirá el efecto de las partículas de nieve
            explotarNieve[i]=true;
            
            //Y tirarNieve volverá ser false para evitar que la bola de nieve siga cayendo
            tirarNieve[i] = false;
            
            //El contador de cumulos de nieve aumentará +1 para monitorear en que momento realizar el cambio de escena
            cumulos++;
          }
        }
      }
    }
  }  
}


//Esta clase nos permitirá crear las particulas de nieve que se producen al impactar la bola de nieve contra el cúmulo de nieve
class ParticulasNieve
{
    //Creamos float para las posiciones y velocidades X e Y
    float x, y, velx, vely;
    //Y creamos una gravedad para que las particulas una vez en su punto más alto comiencen a caer
    float gravedad = 0.07;
    
    //Con este constructor pediremos los datos anteriormente mencionados
    ParticulasNieve(float ox, float oy, float vx, float vy)
    {
      //Igualamos cada variable del contructor a las variable locales
      x = ox;
      y = oy;
      velx = vx; 
      vely = vy;
    }
    
    //Con este método actualizaremos las posiciones en x e y de cada partícula
    void procesar()
    {
        //A la velocidad de Y se le sumará la gravedad para lograr este efecto de caída
        vely += gravedad;
        
        //Y a cada posición se le sumará su correspondiente velocidad
        x += velx;
        y += vely;
    }
    
    //Con este otro método se dibujarán las elipses que simulan los copos de nieve
    void display() {fill(255); ellipse(x, y, 3.2,3.2); noFill();}
}




//Muestra la escena Invierno
void invierno()
{
  //Dibujamos la imagen de fondo de INVIERNO
  image(invierno,0,0,width,height);
  
  
  //Creamos un objeto de la clase atajos para poder hacer uno de menú. Les asignamos sus correspondientes eventos
  Atajos volver_menu = new Atajos(20,20,2);
  volver_menu.display();
  volver_menu.menu();
  
  //Creamos otro objeto de la clase atajos para poder hacer uno de avanzar que nos lleve a la siguiente escena PRIMAVERA con su correspondiente cortina
  //Esto es en caso de que no se pueda terminar la escena
  Atajos avanzar = new Atajos(width*0.965,20,1);
  avanzar.display();
  
  
  //Creamos un objeto de la clase Frase para mostrar la fase "acertijo" correspondiente de la escena 
  Frase f_invierno = new Frase ("... quizás oculto,", "tan oculto que quiebra...");
  f_invierno.display();
  avanzar.accion();
  
  


  //Creamos un array con la clase Nieve de 17 objetos para poder dibujar 17 cúmulos de nieve
  Nieve [] cumulo = new Nieve [17];
  
  //Con este ciclo for asignaremos los 17 cúmuloos
  for (int n=0;n<17;n++)
  {
    //Les pasamos las posciones X e Y del array bidimensional pos_cumulos creado anteriormente
    cumulo[n] = new Nieve(pos_cumulo[n][0], pos_cumulo[n][1]);
    
    //Si el cúmulo de nieve no ha sido impactado aún por la bola de nieve
    if(!explotarNieve[n])
    {
      //El cúmulo de nieve será dibujado
      cumulo[n].display();
    }
    
    //se le asigna a cada objeto el método romperNieve()
    cumulo[n].romperNieve();
    
    
    //Si el cúmulo de nieve es impactado por la bola de nieve
    if (explotarNieve[n])
    {
      //Con este ciclo for recorreremos cada una de las particulas creadas anteriormente y almacenadas en el array bidimendional nieve[][]
      for(int p=0;p<20;p++)
       {
        //Asignamos a cada particula los métodos correspondiente de la clase para que se dibuje y se actualicen sus propiedades
        nieve[n][p].procesar();
        nieve[n][p].display();
       }
    }
    
  }
  
  
  //Monitoreamos que cuando cumulos sea igual a 17, es decir se hayan destruido todos los cúmulos, paso de estación sea TRUE, por lo tanto pasaríamos a PRIMAVERA
  if(cumulos==17){paso_estacion=true;}
 
  
  
  //Con este ciclo se dibujarán y actualizará el comportamiento de cada copo de nieve
  for (int i=0; i<1000;i++)
  {
    //Si la posición Y del copo atraviesa elborde inferior de la pantalla
    if (copos_pos[i][1]> height)
    {
      //La posición Y se actualizará a 0, así vuelve a caer
      copos_pos[i][1] = 0;
    }
    
    //Si la posición x del copo atraviesa el borde izquierdo o derecho de la pantalla
    if (copos_pos[i][0] > width || copos_pos[i][0] < 0)
    {
      //La posición X se actualizará a 0
      copos_pos[i][0] = 0;
    }
    
    //Aquí, sumamos a cada posición X e Y, las velocidades X e Y calculadas anteriormente
    //De esta manera los copos se moverán de maneras diversas pero no rápidamente
    copos_pos[i][0] += copos_vel[i][0];
    copos_pos[i][1] += copos_vel[i][1];
    

    //Quitamos el borde
    noStroke();
    //Rellenamos con transparencia
    fill(#eff1f4, 200);
    //Dibujamos cada copo en las posiciones anteriormente almacenadas en copos_pos[][]
    ellipse(copos_pos[i][0], copos_pos[i][1], 3.2,3.2);
  
  }

}
