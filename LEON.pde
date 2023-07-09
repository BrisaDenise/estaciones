

//LEÓN, Brisa Denise
//Informática Aplicada I
//Cátedra Calcagno
//Licenciatura en Artes Multimediales
//Universidad Nacional de las Artes ATAM


//-------------------------------------------------------------------------------------------------------------------------------------

//Esta variable será usada para almacenar la escena que actualmente se está visualizando
//La primera pantalla en visualizarse: EL MENÚ
String escena_actual = "menu";

//Esta variable contará el tiempo desde que se inicie la aplicación
//Será útil para hacer pasos de pantallas con tiempo
//También será uilizada en la última escena "primavera"
long tiempo=0;


//Esta variable tomará el tiempo de un momento determinado
long tiempo_actual = 0;


//Esta variable guarda el retardo para aparecer la otrapantalla
long retardo = 4000;


//Este bool nos servirá para tomar en un momento en específico el tiempo
//Al activarse, la variable tiempo_actual toma el tiempo transcurrido hasta el momento.
boolean bandera=false;


//Este bool es necesario para crear un tiempo entre paso estacion-cortina de la próx estación
//Será explicado más detalladamente más adelante justo al evento correspondiente
boolean paso_estacion = false;


//Esta variable nos permitirá reiniciar todas las variables
boolean reiniciar;





//************************************ AUDIO *************************************************

//Importamos la libreía minim para el audio
import ddf.minim.*;

//Creamos un objeto Minim
Minim minim;

//Cargamos los dos audios a utilizar para la escena de OTOÑO: las hojas y el soplo de viento
AudioSample viento;
AudioSample hoja;

//Cargamos el audio a utilizar en la escena de INVIERNO: nieve impactando
AudioSample golpe_nieve;

//Cargamos el audio a utilizar en la escena de PRIMAVERA: la flor abriendose
AudioSample mov_flor;

//Cargamos la música de fondo
AudioPlayer musica;


//********************************************************************************************







//************************************ IMÁGENES *************************************************
//Declaramos las imágenes que usaremos en todo el código


//>>VERANO (pantalla principal y final)<<
PImage verano_fondo;


//>>PRIMAVERA<<
PImage primavera_fondo;
PImage flor;
PImage capullo;


//>>INVIERNO<<
PImage invierno;
PImage cumulo_nieve;
PImage bola_nieve;


//>>OTOÑO<<
PImage otono_fondo;
PImage hoja_izquierda;
PImage hoja_derecha;


//>>BOTONES DE ATAJOS<<
PImage [][] atajos = new PImage [4][2];

//***********************************************************************************************





//************************************ FUENTES *************************************************
//Declaramos las fuentes a utilizar

PFont fuente;
PFont fuente_sec;
PFont titulo;

//**********************************************************************************************





//-----------------------VARIABLES OTOÑO---------------------------------------------------------------------------------------------------

//Creamos un array bidimensional que contendrá todas las posiciones x e y para cada una de las hojas del árbol en la estación OTOÑO
float [] [] pos_hojas;

//Creamos un array boolean que nos va a permitir identificar qué hoja debe caer la posición del mouse
boolean [] que_hoja = new boolean [25];

//Con este int contaremos cuantas hojas se han caído. Si el total es igual a 25 pasa a la siguiente escena. Es decir, termina OTOÑO
int hojas;

//-----------------------------------------------------------------------------------------------------------------------------------------






//-----------------------VARIABLES INVIERNO--------------------------------------------------------------------------------------------------

//Con este array bidimensional guardaremos las posiciones X e Y de los copos de nieve que caerán independientemente en la escena de INVIERNO
float [] [] copos_pos;

//Con este otro array bidimensional se guardarán las distintas velocidades que tomarán los copos de nieve en la escena de INVIERNO
float [] [] copos_vel;


//Este array bidimensional nos ayudará a guardar las posiciones de los distintos cúmulos de nieve en las ramas del árbol
float [] [] pos_cumulo;

//Con este array booleano definiremos cuando arrojar bolas de nieve a los cúmulos
boolean [] tirarNieve = new boolean [17];
//Y con este otro, cuando "explotar" los cúmulos de nieve
boolean [] explotarNieve = new boolean [17];


//Con este array guardaremos la posición Y de caída de cada bola de nieve
float [] bola_posY = new float [17];
//Y con este otro, la posición en X que mantendrá cada bola de nieve
float [] bola_posx =  new float [17];

//Con este contador, al llegar a determinado número, pasaremos de la escena INVIERNO a PRIMAVERA
int cumulos;


//Este array bidimensional creado de una clase local "ParticulasNieve" definirá las propiedades de un conjunto de particulas que simulan la nieve
//Lo que se busca es que cada cúmulo, al ser impactado expulse nieve, por lo tanto se hacen un total de 17 grupos de particulas (porque son 17 cúmulos) de 20 pasticulas c/u.
//Se explicará detalladamente más adelante
ParticulasNieve [][] nieve = new ParticulasNieve[17][20];

//-----------------------------------------------------------------------------------------------------------------------------------------







//-----------------------VARIABLES PRIMAVERA--------------------------------------------------------------------------------------------------

//Con este array bidimensional cargaremos los 3 vertices (x,y) que componene al rayo de sol (figura triangular)
float [][] rayo_luz;

//Con este array bidimensional cargaremos las posiciones x e y de cada una de las flores
float [][] flores;

//Este array boolean nos permitirá saber cuando una determinada flor es impactada por el "rayo de sol"
boolean [] abrir_flor = new boolean [20];

//Este otro array boolean nos permitirá saber cuando una determina flor ya ha florecido
boolean [] florecida = new boolean [20];

//Este array guardará el valor en tiempo del momento en que la flor comienza a crecer
long[] tiempos_flores = new long[20];

//Con este contador sumaremos la cantidad de flores abiertas
int flores_abiertas;

//---------------------------------------------------------------------------------------------------------------------------------------------




void setup()
{
  //Definimos fullscreen para ver nuestra aplicación en pantalla completa
  fullScreen();
  //Definimos el color blanco de fondo
  background(0);
  //Definimos que el modo de dibujo de los rectángulos sea del centro
  rectMode(CENTER);
  
  
  
  //*************************** FUENTES *****************************
  //Cargamos la fuente a utilizar a lo largo de la aplicación
  fuente = loadFont("SueEllenFrancisco-50.vlw");
  fuente_sec = createFont("Flamenco-Regular.ttf", 16);
  titulo = createFont("PrincessSofia-Regular.ttf", 80);
  
  
  
  //*************************** IMÁGENES *****************************
  //Cargamos las imágenes de las escenas
  
  
  //>>VERANO<<
  //Imagen de fondo utilizada en la pantalla de incio y la pantalla final
  verano_fondo = loadImage("verano_background.png");
  
  
  //>>OTOÑO<<
  //Cargamos las imágenes a utilizar en la escena OTOÑO: El fondo y las hojas (una mirando a la derecha y otra a la izquierda)
  otono_fondo = loadImage("otoño_background.png");
  hoja_izquierda = loadImage("otoño_hoja_izquierda.png");
  hoja_derecha = loadImage("otoño_hoja_derecha.png");
  
  
  //>>INVIERNO<<
  //Cragamos las imagenes a utilizar en la escena INVIERNO: El fondo, el cúmulo de nieve y la bola de nieve
  invierno=loadImage("invierno_background.png");
  cumulo_nieve=loadImage("nieve.png");
  bola_nieve=loadImage("bola_nieve.png");
  
  
  //>>PRIMAVERA<<
  //Cragamos las imagenes a utilizar en la escena PRIMAVERA: El fondo, la flor y el capullo
  primavera_fondo = loadImage("primavera_background.png");
  flor = loadImage("flor.png");
  capullo = loadImage("capullo.png");
  
  
  
  //>>ATAJOS<<
  //Cuando el mouse esté por arriba de un atajo "MOUSE OVER", la imagen cambia de color: de NEGRO a VERDE
  //Es decir que utilizamos estos arrays bidimensionales para guardar la imagen de cada atajo cuando no tiene el mouse encima y otra cuando el mouse sí esta encima 
  atajos[0][0]=loadImage("salir.png");
  atajos[0][1]=loadImage("salir_v.png");
  atajos[1][0]=loadImage("avanzar.png");
  atajos[1][1]=loadImage("avanzar_v.png");
  atajos[2][0]=loadImage("menu.png");
  atajos[2][1]=loadImage("menu_v.png");

  
  
  
  
  //*************************** AUDIO *****************************
  
  //Creamos el objeto minim
  minim = new Minim(this);
  
  //Cargamos los dos samplers a reproducir al tirar la hoja: hoja quedrandose y soplo de viento
  viento = minim.loadSample("viento.wav");
  hoja = minim.loadSample("hoja.wav");
  
  //Cargamops el sampler a reproducir al impactar el cúmulo de nieve
  golpe_nieve = minim.loadSample("nieve.wav");
  
  //Cargamos el sampler a reproducir cuando una flor se abre
  mov_flor=minim.loadSample("flor.wav");
  
  //Cargamos el archivo de la música
  musica = minim.loadFile("estaciones_musica_original.wav", 2048);
  //Lo reproducimos
  musica.play();
  //Y lo loopeamos
  musica.loop();
  
  //Como luego la aplicación se puede reiniciar, realizamos el siguiente condicional
  //Si el estado reiniciar es true
  if(reiniciar)
  {
    //Detenemos la nueva música, porque se superpondría a la primera
    musica.pause();
  }
  
  
  
  
  //**************************************** VARIABLES OTOÑO *****************************************
  
   //Iniciamos el contador en 0. Cada vez que se caiga una hoja, el contador irá sumando 1
   hojas = 0;
   
   //Creamos el nuevo array float bidimensional de 25x2: se tendrán 25 HOJAS con 2 POSICIONES (X e Y)
   pos_hojas = new float [25][2];
   
   
   //A continuación se cargan cada una de las posiciones de cada hoja del árbol en la escena OTOÑO
   
   //Notese que para posición en X se utiliza el índice 0
   pos_hojas [0][0] = width*0.3;
   //Y para posición en Y, el índice 1
   pos_hojas [0][1] = height*0.5;
   
   pos_hojas [1][0] = width*0.21;
   pos_hojas [1][1] = height*0.29;
   
   pos_hojas [2][0] = width*0.24;
   pos_hojas [2][1] = height*0.155;
   
   pos_hojas [3][0] = width*0.32;
   pos_hojas [3][1] = height*0.25;
   
   pos_hojas [4][0] = width*0.34;
   pos_hojas [4][1] = height*0.16;
   
   pos_hojas [5][0] = width*0.34;
   pos_hojas [5][1] = height*0.005;
   
   pos_hojas [6][0] = width*0.405;
   pos_hojas [6][1] = height*0.03;
   
   pos_hojas [7][0] = width*0.45;
   pos_hojas [7][1] = height*0.11;
   
   pos_hojas [8][0] = width*0.51;
   pos_hojas [8][1] = height*0.05;
   
   pos_hojas [9][0] = width*0.57;
   pos_hojas [9][1] = height*0.04;
   
   pos_hojas [10][0] = width*0.595;
   pos_hojas [10][1] = height*0.18;
   
   pos_hojas [11][0] = width*0.65;
   pos_hojas [11][1] = height*0.04;
   
   pos_hojas [12][0] = width*0.725;
   pos_hojas [12][1] = height*0.245;
   
   pos_hojas [13][0] = width*0.27;
   pos_hojas [13][1] = height*0.32;
   
   pos_hojas [14][0] = width*0.37;
   pos_hojas [14][1] = height*0.22;
   
   pos_hojas [15][0] = width*0.465;
   pos_hojas [15][1] = height*0.19;
   
   pos_hojas [16][0] = width*0.494;
   pos_hojas [16][1] = 0;
   
   pos_hojas [17][0] = width*0.637;
   pos_hojas [17][1] = 0;
   
   pos_hojas [18][0] = width*0.295;
   pos_hojas [18][1] = height*0.04;
   
   pos_hojas [19][0] = width*0.725;
   pos_hojas [19][1] = height*0.13;
   
   pos_hojas [20][0] = width*0.66;
   pos_hojas [20][1] = height*0.425;
   
   pos_hojas [21][0] = width*0.8;
   pos_hojas [21][1] = height*0.205;
   
   pos_hojas [22][0] = width*0.68;
   pos_hojas [22][1] = height*0.26;
   
   pos_hojas [23][0] = width*0.74;
   pos_hojas [23][1] = height*0.352;
   
   pos_hojas [24][0] = width*0.55;
   pos_hojas [24][1] = height*0.2;
 
 
 
 
 
 
 //**************************************** VARIABLES INVIERNO ************************************************************************************
 
 //Creamos los arrays de la posición y velocidad de los copos de nieve
 //En total serán 1000 copos de nieve en escena
 copos_pos = new float [1000][2];
 copos_vel = new float [1000][2];
 
 //Con un ciclo for asignamos valores a cada índice de los anteriores arrays
 for (int i=0; i < 1000; i++)
 {
   //Con respecto a las posiciones, para las posición x ([i][0]) se seleccionará un número aleatorio entre 0 y el width de la pantalla
   //Para la posición y ([i][1]) se seleccionará un número aleatorio entre el 0 y el height de la pantlla
   copos_pos[i][0] = random(0, width);
   copos_pos[i][1] = random(0, height);
   
   //Con respecto a las velocidades, para la velocidad de x ([i][0]) se seleccionará un número aleatorio entre -1.5 y 1.5
   //Y para la velocidad de y ([i][1]) se seleccionará un número aleatorio entre 0.5 y 2
   copos_vel[i][0] = random(-1.5,1.5);
   copos_vel[i][1] = random(0.5,2); 
 }
 
 
 
 
 //Creamos el array bídimensional de las posiciones de cada cúmulo de nieve, donde habrá un total de 17 CÚMULOS
  pos_cumulo = new float [17][2];
  
  //A continuación se cargan todas las posiciones
  pos_cumulo[0][0] = width*0.3;
  pos_cumulo[0][1] = height*0.07;
  
  pos_cumulo[1][0] = width*0.26;
  pos_cumulo[1][1] = height*0.16;
  
  pos_cumulo[2][0] = width*0.21;
  pos_cumulo[2][1] = height*0.26;
  
  pos_cumulo[3][0] = width*0.3;
  pos_cumulo[3][1] = height*0.45;
  
  pos_cumulo[4][0] = width*0.27;
  pos_cumulo[4][1] = height*0.325;
  
  pos_cumulo[5][0] = width*0.35;
  pos_cumulo[5][1] = height*0.155;
  
  pos_cumulo[6][0] = width*0.495;
  pos_cumulo[6][1] = height*0.035;
  
  pos_cumulo[7][0] = width*0.55;
  pos_cumulo[7][1] = height*0.025;
  
  pos_cumulo[8][0] = width*0.4;
  pos_cumulo[8][1] = height*0.395;  
  
  pos_cumulo[9][0] = width*0.38;
  pos_cumulo[9][1] = height*0.305;  
  
  pos_cumulo[10][0] = width*0.54;
  pos_cumulo[10][1] = height*0.19; 
  
  pos_cumulo[11][0] = width*0.605;
  pos_cumulo[11][1] = height*0.06; 
  
  pos_cumulo[12][0] = width*0.71;
  pos_cumulo[12][1] = height*0.13; 
  
  pos_cumulo[13][0] = width*0.61;
  pos_cumulo[13][1] = height*0.345; 
  
  pos_cumulo[14][0] = width*0.67;
  pos_cumulo[14][1] = height*0.25; 
  
  pos_cumulo[15][0] = width*0.72;
  pos_cumulo[15][1] = height*0.35; 
  
  pos_cumulo[16][0] = width*0.645;
  pos_cumulo[16][1] = height*0.41; 
  
  
 //Iniciamos el contador de cúmulos en 0 
 cumulos=0;
 
 
 //Asignamos FALSE a todo el array booleano de explotarNieve
 //Esto nos va a servir cuando del menú final volvamos al inicio y tengamos que reiniciar la escena
 for (int e=0; e<17; e++)
 {
   explotarNieve[e]=false;
 }
 
 
 
 //Con los siguiente ciclos anidados vamos a asignar a cada particula de los 17 grupos de 20 partículas, sus posiciones X e Y y sus velocidades X e Y
 for (int pp = 0; pp<17;pp++)
 {
   for(int p=0;p<20;p++)
   {
     //Para la velocidad en x hacemos un random de entre -4 a 4
     float velX = random (-4,4);
     //T para la velocidad en y sumamos a -p, 10 para de esa manera crear una explosión circular
     float velY = -p+10;
     
     //asignamos las posiciones X e Y correspondientes a su cúmulo y las velocidades anteriormente calculadas
     nieve[pp][p]= new ParticulasNieve( pos_cumulo[pp][0]+14, pos_cumulo[pp][1]+9, velX, velY);
     
   }
 }
  
  
 
 
 

  
  
  
  
  //**************************************** VARIABLES PRIMAVERA ****************************************************************************************
 
  //Con el siguiente for recorrermos cada indice de abrir_flor y florecida para ponerlo en false. Así como asignar valor 0 a cada indice de tiempo_flores
  //Esto nos va a servir cuando del menú final volvamos al inicio y tengamos que reiniciar la escena
  for (int fl =0; fl<20;fl++)
  {
    abrir_flor[fl]=false;
    florecida[fl]=false;
    tiempos_flores[fl]=0;
  }
  
  
  //Con este contador llevaremos la cuenta de cuantas flores han sido abiertas para pasar a la pantalla final
  flores_abiertas = 0;
  
  
  //Creamos el array bidimensional con los vertices (x e y) que compondrán nuestro triángulo
  rayo_luz = new float [3][2];
  
  
  //Creamos el array bidimensional para cada posición x e y de cada flor: en total serán 20 flores
  flores = new float [20][2];
  
  //A continuació cargamos cada una de las posiciones
  flores[0][0] = width*0.35;
  flores[0][1] = height*0.25;
  
  flores[1][0] = width*0.28;
  flores[1][1] = height*0.33;
  
  flores[2][0] = width*0.31;
  flores[2][1] = height*0.45;
  
  flores[3][0] = width*0.21;
  flores[3][1] = height*0.26;
  
  flores[4][0] = width*0.25;
  flores[4][1] = height*0.11;
  
  flores[5][0] = width*0.34;
  flores[5][1] = height*0.13;
  
  flores[6][0] = width*0.3;
  flores[6][1] = height*0.03;
  
  flores[7][0] = width*0.4;
  flores[7][1] = height*0.01;
  
  flores[8][0] = width*0.46;
  flores[8][1] = height*0.19;
  
  flores[9][0] = width*0.51;
  flores[9][1] = height*0.07;
  
  flores[10][0] = width*0.54;
  flores[10][1] = height*0.23;
  
  flores[11][0] = width*0.6;
  flores[11][1] = height*0.17;
  
  flores[12][0] = width*0.58;
  flores[12][1] = height*0.02;
  
  flores[13][0] = width*0.69;
  flores[13][1] = height*0.07;
  
  flores[14][0] = width*0.715;
  flores[14][1] = height*0.16;
  
  flores[15][0] = width*0.66;
  flores[15][1] = height*0.24;
  
  flores[16][0] = width*0.77;
  flores[16][1] = height*0.25;
  
  flores[17][0] = width*0.61;
  flores[17][1] = height*0.35;
  
  flores[18][0] = width*0.66;
  flores[18][1] = height*0.425;
  
  flores[19][0] = width*0.73;
  flores[19][1] = height*0.39;
}






void draw()
{
  //Comenzamos a contar el tiempo desde que se ejecuta la aplicación dentro de la variable tiempo
  tiempo=millis();
  
  //Con este switch cambiamos las pantallas visualizadas según la variable escena_actual
  //Comenzamos viendo la pantalla del menú
  switch (escena_actual)
  {
    
    //Cuando escena_actual es igual a menu, se ejecuta el evento menuInicio() el cual posee todas las propiedades del menú
    case "menu":
      
      menuInicio();
      
      //Cuando el bool reiniciar sea TRUE, se ejecutará el setup() lo que reestablecerá las variables a su valor origen y automáticamente se la desactivará.
      if (reiniciar) {setup(); reiniciar=false;}

      break;
      
      
     //Cuando escena_actual es igual a estaciones, pasamos a la pantalla de elección de escenas donde podemos elegir a qué estación ir
     //Se ejecuta el evento estaciones() con todas las propiedades de esta pantalla
    case "estaciones":
      estaciones();
      break;
      
      
    //Esta es la primera pantalla que vemos al presionar el botón EMPEZAR del menú, por lo tanto, es la primera ESTACIÓN -> OTOÑO
    //También es la pantalla que veremos al presionar la escena OTOÑO dentro de Estaciones (pantalla de selección de niveles)
    //Esta pantalla aparece unos 4 segundos, por lo tanto, es este caso, se ejecutan dos eventos: cortinaOtono() y cambiarEscena()
    //cambiarEscena tendrá el elemento "otoño" porque se trata de la escena a la que queremos ir (se verá más adelante)
    case "cortina_otoño":
      cortinaOtono();
      cambiarEscena("otoño");
      break;
      
      
    //Ejecuta la escena de la estación OTOÑO con el evento otono()
    case "otoño":
      otono();
      
      //Con este condicional pasamos a la siguiente escena (en este caso, invierno)
      //paso_estacion será explicado más adelante
      if (paso_estacion)
      {
        //Para que el paso entre escenas no sea brusco, se utiliza el mismo retardo que utilizan las cortinas
        //Entonces, una vez que paso_estacion cambia a true (es decir, se ha acabado todo lo que había que hacer en la escena de la estación actual), la escena se mostrará por otros 4 segundos y luego, aparecerá la cortina de la prox escena
        cambiarEscena("cortina_invierno");
      }
      
      break;
      
      
    //Ejecuta la cortina de las segunda estación: INVIERNO, se verá después de completar la escena de OTOÑO
    //También aparecerá al seleccionar INVIERNO en la pantalla ESCENAS
    //Al igual que en la anterior cortina, aparecerá por 4 segundos y luego saltará a la escena de INVIERNO
    //Se ejecutan los eventos cortinaInvierno() y cambiarEscena("invierno") (porque la escena a la que queremos ir es a INVIERNO)
    case "cortina_invierno":
      cortinaInvierno();
      cambiarEscena("invierno");
      break;
      
      
    //Ejecuta la escena de la estación INVIERNO con el evento invierno() 
    case "invierno":
      invierno();
      
      //Con este condicional pasamos a la siguiente escena (en este caso, primavera)
      if (paso_estacion)
      {
        //Al igual que en el caso anterior, este evento genera un retardo de 4 segundos para pasar a la próxima cortina: la cortina de de primavera
        cambiarEscena("cortina_primavera");
      }
      break;
      
      
    //Ejecuta la cortina de la estación PRIMAVERA luego de completar la escena INVIERNO
    //También aparecerá al presionar el botón PRIMAVERA en la pantalla Estaciones
    //Al igual que en las anteriores, aparecerá por 4 segundos y luego saltará a la escena de PRIMAVERA
    //Para ello, se ejecutan los eventos cortinaPrimavera() y cambiarEscena("primavera") porque es a la escena donde queremos ir -> PRIMAVERA
    case "cortina_primavera":
      cortinaPrimavera();
      cambiarEscena("primavera");
      break;
      
      
    //Ejecuta la escena de la estación PRIMAVERA con el evento primavera() 
    case "primavera":
      primavera();
      
      //Con este condicional pasamos al MENÚ FINAL
      if (paso_estacion)
      {
        //Al igual que en los casos anteriores, este evento genera un retardo de 4 segundos para pasar a la próxima y última pantalla: el menú final
        cambiarEscena("cortina_final");
      } 
      break;
      
    //Ejecuta la cortina final antes de llegar a "Verano"
    //Luego de 4 segundos pasará a mostrarse la pantalla FINAL
    case "cortina_final":
      cortinaFinal();
      cambiarEscena("final");
      break;
      
    //Ejecuta el menú final con el evento menuFinal()  
    case "final":
      menuFinal();
      break;
    
    }
  }
  

 
  
  
void mousePressed()
{
  //---------------------------------------------------------- EN INVIERNO -------------------------------------------------------------

  //Cuando estemos dentro de la escena INVIERNO, se activará el siguiente condicional
  if (escena_actual == "invierno")
  {
    //Con este for recorreremos todo el array bidimensional de las posiciones de cada cúmulo de nieve 
     for (int i=0; i<17; i++)
      {
        //Si se clickea dentro de la imagen de uno de los cúmulos de nieve
        if (mouseX > pos_cumulo [i][0] && mouseX< pos_cumulo [i][0]+ 28 && mouseY > pos_cumulo [i][1] && mouseY < pos_cumulo [i][1]+19) 
        {
          if(!tirarNieve[i])
          {
            //Se le asignará al índice correspondiente de bola_posx la posición de mouseX
            //Se esta forma la bola de nieve caera en línea recta por arriba de donde se encuentra mouseX
            bola_posx [i]=mouseX;
            
            //A bola_posY se le asignará 0 para que la bola de nieve surga de arriba y fuera de la pantalla
            bola_posY [i]=0;
            
            //el boolean tirarNieve del cúmulo correspondiente se pondrá en true para que la bola de nieve comience a caer
            //Para esto se utiliza la clase Nieve y su método romperNieve()
            tirarNieve[i]=true;
          }
        }
      }
  }
  
  
  //---------------------------------------------------------- EN LA PANTALLA FINAL ------------------------------------------------------------------
   
  //Con este condicional, si nos encontramos en la pantalla final
  if (escena_actual == "final")
  {
    //Y se realiza un click dentro del recuadro "Volver", reiniciar = TRUE
    //De esta forma, se resetearán todo los valores para volver a interactuar con las escena de OTOÑO (en el futuro, con las de INVIERNO y PRIMAVERA)
    if(mouseX > (width*0.4958-100) && mouseX < (width*0.4958+100) && mouseY > (height*0.65-35) && mouseY < (height*0.65+35)) {reiniciar=true;}
  }
   
}




//Creamos la clase Botones con la que se crearán los botones de navegación con texto de la aplicación
class Botones
{
  //Se definen las variables a utilizar en la clase para posición y texto
  float posx, posy;
  String texto;
  
  //Se arma un constructor para obtener valores particulares de posición y texto según lo requiera el botón
  Botones(float pos_X, float pos_Y, String titulo){
    
    //Se iguala cada variable del constructor a las variables locales de la clase
    posx=pos_X;
    posy=pos_Y;
    texto=titulo;
  }
  
  
  //Con el siguiente método, se muestra el botón
  void display()
  {
    //Para crear un efecto de MOUSE OVER se aplica el siguiente condicional
    //Si el mouse está sobre ese recuadro imaginario, el color del texto será verde
    if(mouseX > (posx-50) && mouseX < (posx+50) && mouseY > (posy-10) && mouseY < (posy+10)) {fill(#8CA210);} 
    
    //Si no, el color será marron oscuro
    else{fill(#211512);}
    
    
    //Centramos en X e Y el texto
    textAlign(CENTER, CENTER);
    //Definimos la fuente y tamaño a utilizar
    textFont(fuente, 31);
    //Mostramos el texto según el string y posiciones X e Y escritas en el constructor
    text(texto, posx, posy);
    //Detenemos el relleno
    noFill();
  }
  
  
  
  //Con este método se configura que pasa al presionar el botón anteriormente creado
  void tocarBoton(String escena_eleg)
  {
    //Si el mouse es presionado y la tecla es la izquierda
    if (mousePressed && mouseButton==LEFT)
    {
      //Y si además el cursor se encuentra dentro del rectángulo
      //Para ello el mouseX debe estar dentro de la posicion X - 50  y posicioX + 50 
      //Y mouseY dentro de la posicionY - 10 y posicionY + 10
      if(mouseX > (posx-50) && mouseX < (posx+50) && mouseY > (posy-10) && mouseY < (posy+10))
      {
        //escena_actual pasará a ser escena_eleg (elegida) por lo que ahora se mostrará la escena seleccionada
        escena_actual = escena_eleg;
        
        //bandera será igual a TRUE, permitiendo volver a tomar el tiempo
        //Esta activación es necesaria una primera vez ya que bandera inicia como FALSE.
        bandera=true;
      }
    }
  }
}







//Este evento nos permitirá tomar el tiempo de un momento específico
//Útil para el paso entre escena y la última escena primavera
void tomarTiempo()
{
  //Acá, utilizamos el bool bandera
  //Como dijimos anteriormente, se utiliza para guardar el tiempo de un momento determinado
  //Entonces, cuando bandera==true, este condicional se habilita
  if (bandera==true)
  {
    //Asignamos a tiempo_actual el valor de tiempo
    tiempo_actual=tiempo;
    //Y automáicamente, desactivamos la bandera así el condicional se desahabilita
    bandera=false;
  }
}






//Con este evento se establece el tiempo que aparecen las cortinas y el tiempo de espera entre pasos de escena
//Es decir, cada cortina va a aparecer por un total de 4 segundos y luego desaparecerá, tomando su lugar la escena correspondiente
//Y por otro lado, el tiempo que pasará hasta pasar a la próxima escena, es decir, también 4 segundos

//El evento contiene una variable llamada escena_sig, es decir que busca recibir cual es la escena que sigue a la actual
void cambiarEscena(String escena_sig)
{
  //Llamamos a nuestro evento que toma el tiempo en un momento determinado
  //Aquí se le asigna a tiempo_actual un valor
  tomarTiempo();
  
  //Preguntamos si el tiempo (el cual sigue corriendo) es mayor al tiempo_actual (conseguido anteriormente) más el retardo
  //De esta forma se le suma al tiempo_actual + 4 segundos. Logrando que la pantalla se visualice por 4 segundos
  //Una vez que el tiempo supere esos 4 segundo de diferencia, pasará a la siguiente pantalla

  if (tiempo > tiempo_actual+retardo)
  {
    //escena_actual será igual a la escena_sig logrando el paso de escenas
    escena_actual=escena_sig;
    
    //paso_estacion que sirve para el paso entre escenas luego de finalizar una, se vuelve FALSE
    paso_estacion=false;
    
    //bandera vuelve a ser true, de esta manera queda activado para la próxima vez que se llame al evento
    bandera=true;  
  }
}








//Esta clase nos permitirá cargar todas las caracteristicas y acciones que tienen un atajo (pequeños símbolos que están en la parte superior de la pantalla)
class Atajos
{
  
  //Se definen las variables a utilizar en la clase: posición y tipo de imagen (varía dependiendo que atajo se quiera)
  float posx,posy;
  int tipo_img;
  
  //Armamos un constructor para obtener posiciones y tipo de imagen (se utiliza un int debido a que lo usaremos como índice en el array bidimensional atajos[][])
  Atajos(float x, float y, int imagen)
  {
    posx = x;
    posy = y;
    //Los 3 tipos de imagenes que se pueden elegir son: 1)salir | 2)avanzar | 3)menú
    tipo_img = imagen;
  }
  
  
  
  //Con este evento mostramos el atajo
  void display()
  {
    //Para crear un efecto de MOUSE OVER se utiliza el siguiente condicional
    //Si el mouse está sobre la imagen del atajo
    if(mouseX > (posx-10) && mouseX < (posx+30) && mouseY > (posy-10) && mouseY < (posy+30))
    {
      //Entonces la imagen a utilizar será atajos[x][1] ya que esa guarda la imagen en verde
      image(atajos[tipo_img][1], posx, posy);
    }
    
    //Si no, la imagen será atajos [x][0] que guarda la imagen en negro
    else{image(atajos[tipo_img][0], posx, posy);}
    
  }
  
  
  
  //Con este evento lograremos que el atajo que tenga la imagen de menú, al clickearlo, nos direccione a la escena MENÚ
  //Esta acción está separada de las otras debido a que suele aparecer con otra en pantalla
  void menu()
  {
    //Si el mouse está dentro del atajo
    if(mouseX > (posx-10) && mouseX < (posx+30) && mouseY > (posy-10) && mouseY < (posy+30))
    { 
      //Y si se realiza un click con el botón izquierdo, escena_actual cambiará a menú y ademas se reiniciará setup (esto es para que las escenas se reinicien)
      if (mousePressed && mouseButton==LEFT){escena_actual = "menu"; reiniciar=true;}
    }
  }
  
  
  
  //Con este otro evento definimos otras acciones a realizar por los botones salir y avanzar
  void accion()
  {
    //Si el mouse está por encima de la imagen del atajo
    if(mouseX > (posx-10) && mouseX < (posx+30) && mouseY > (posy-10) && mouseY < (posy+30))
    {
      //Y si se clickea con el botón izquierdo
      if (mousePressed && mouseButton==LEFT)
      {
        //Con este switch, recorreremos las acciones ha realizar segun sea la escena actual
        switch (escena_actual)
        {
          //Si la escena actual es MENÚ, el atajo corresponde a cerrar la aplicación
          case "menu":
            exit();
            break;
          
          //Si la escena actual es FINAL, el atajo corresponde a cerrar la aplicación
          case "final":
            exit();
            break;
          
          //Si la escena actual es OTOÑO, el atajo AVANZAR debe hacerte pasar a la escena siguiente con su correspondiente cortina: INVIERNO
          case "otoño":
            escena_actual = "cortina_invierno";
            break;
          
          //Si la escena actual es INVIERNO, el atajo AVANZAR debe hacerte pasar a la escena siguiente con su correspondiente cortina: PRIMAVERA
          case "invierno":
            escena_actual = "cortina_primavera";
            break;
          
          //Si la escena actual es PRIMAVERA, el atajo AVANZAR debe hacerte pasar a la última pantalla: FINAL
          case "primavera":
            escena_actual = "cortina_final";
            break;
        }
      }
    }
  }
}



//Con esta clase, crearemos las frases de "orientación" en cada nivel
class Frase
{
  //Utilizaremos dos strings, ya que las frases se construirán de dos partes
  String t1,t2;
  
  //Con un construtor pediremos esas dos partes
  Frase(String text1, String text2)
  {
    t1=text1;
    t2=text2;
  }
  
  
  //Con este evento mostraremos las frases
  void display()
  {
    //Definimos la fuente a utilizar
    textFont(fuente,  22);
    //Lo alineamos a la izquierda
    textAlign(LEFT);
    //Lo rellenamos de negro con un poco de opacidad
    fill(0, 160);
    
    //Escribimos los textos con posiones x e y convenientes para que nos quede desplazado el texto a la izquierda
    text(t1, width*0.1,height*0.64);
    text(t2, width*0.15,height*0.668);
    
    //Detenemos el relleno
    noFill();
  }
}



//Esta sección la utilizaremos para escribir el texto explicativo, mis datos y el título
void textoPantalla()
{
  //TEXTO EXPLICATIVO
  //Seleccionamos la fuente
  //textFont(fuente_sec);
  //Alineamos el texto la derecha para el texto explicativo
  //textAlign(LEFT);
  //Deinimos el color negro con un poco de transparencia
  //fill(0,220);
  //Escribimos el texto explicativo
  //text("\"Estaciones\" se trata de un pequeño videojuego en el que deberás ayudar a un árbol a enfrentarse a las distintas estaciones del año. Representando el ciclo sin fín que significa la naturaleza y el cuidado que debemos tener para con ella, \"Estaciones\" ahonda en la simpleza y belleza de las pequeñas cosas.", width*0.165,height*0.93,340,225);
  
  
  //DATOS PERSONALES
  //Alineamos a la derecha para agregar mis datos
  //textAlign(RIGHT);
  //Escribimos mis datos
  //text("Brisa Denise León\nInformática Aplicada I\nCátedra Calcagno\nLicenciatura en Artes Multimediales\nUniversidad Nacional de las Artes ATAM", width*0.83,height*0.96,340,225);
  //Detenemos el relleno
  noFill();
  
  
  //TITULO
  //Definimos el tipo de letra y su tamaño
  textFont(titulo,70);
  //Alineamos al centro
  textAlign(CENTER, CENTER);
  //Definimos el color
  fill(#211512,220);
  //Escribimos el título
  text("EstacioneS",width/2, 95);
  //Detenemos el relleno
  noFill();
}




//Con esta clase crearemos las cortinas de cada escena
class Cortinas
{
  //Trabajaremos con un string que pida el nombre de la estación
  String escena;
  
  //Creamos un constructor
  Cortinas(String nombre) {escena=nombre;}
  
  //Definimos el evento para visualizar la cortina
  void display()
  {
    //Establecemos el fondo de pantalla negro
    background(0);
    
    //Definimos el color del texto
    fill(240);
    
    //Alineamos al centro de la pantalla el texto
    textAlign(CENTER, CENTER);
    
    textFont(fuente, 35);
    
    //Definimos el texto a mostrar, y la posición
    text(escena, width/2, height/2);
    
    //Detenemos el relleno
    noFill();
  }
}




//Muestra el menú Inicial
void menuInicio()
{
  //Dibujamos la imagen de fondo que corresponderá a VERANO
  image(verano_fondo,0,0,width,height);
  
  //Creamos 2 nuevos botones para EMPEZAR LA APLICACIÓN y para ESTACIONES (selección de escenas)
  Botones inicio = new Botones(width/2, height*0.4, "Empezar");
  Botones niveles = new Botones(width/2, height*0.46, "Escenas");
  
  //Se mostrarán ambos botones
  inicio.display();
  niveles.display();
  
  //Se mostrarán ambos botones
  inicio.tocarBoton("cortina_otoño");
  niveles.tocarBoton("estaciones");
  
  //Creamos un atajo para cerrar la aplicación y le accionamos sus correspondientes métodos
  Atajos salir = new Atajos(20,20,0);
  salir.display();
  salir.accion();
  
  //Dibujamos el texto explicativo, mis datos y el título
  textoPantalla();
}




//Muestra la pantalla donde se puede seleccionar entre las ditintas escenas: Otoño, Invierno y Primavera
void estaciones()
{
  //Dibujamos la imagen de fondo que corresponde a la estación VERANO
  image(verano_fondo,0,0,width,height);
  
  //Creamos 3 nuevos botones para la selección de cada una de las 3 escenas
  //Cada uno posicionado respectivamente a un 25%, 50% y 75% de la pantalla
  Botones otono = new Botones (width/2, height*0.385, "Otoño");
  Botones invierno = new Botones (width/2, height*0.44, "Invierno");
  Botones primavera = new Botones (width/2, height*0.495, "Primavera");
  
  //Mostramos todos los botones
  otono.display();
  invierno.display();
  primavera.display();  
  
  //Se ejecutan el método tocarBoton para los tres botones
  //Dentro de los paréntesis, se escribe la pantalla seleccionada 
  invierno.tocarBoton("cortina_invierno");
  otono.tocarBoton("cortina_otoño");
  primavera.tocarBoton("cortina_primavera");
  
  //Creamos un objecto de la clase Atajos para crear que nos vuelva al menu con sus correspondientes eventos
  Atajos volver_menu = new Atajos(20,20,2);
  volver_menu.display();
  volver_menu.menu();
  
  //Dibujamos el texto explicativo, mis datos y el título
  textoPantalla();
}





//Muestra la cortina final
void cortinaFinal()
{
  Cortinas c_final = new Cortinas("...el Verano ya llegó\ny mi vida vuelve a iniciar...");
  c_final.display();
}





//Muestra el menú final
void menuFinal()
{
  //Definimos el color de fondo blanco
  image(verano_fondo,0,0,width,height);
  
  //Creamos un objeto de la clase Atajo para hacer un que cierre nuestra aplicación y le asignamos sus correspondientes eventos
  Atajos salir = new Atajos(20,20,0);
  salir.display();
  salir.accion();
  
  //Para escribir el "...gracias" final
  //Seleccionamos la fuente
  textFont(fuente,30);
  //Alineamos el texto la derecha para el texto explicativo
  textAlign(CENTER);
  //Deinimos el color negro con un poco de transparencia
  fill(#211512);
  //Escribimos el texto explicativo
  text("... gracias.", width/2,height*0.45);
  //Detenemos el relleno
  noFill();
  
  
  //Con un objeto de Botones, definimos un nuevo botón
  //Definimos dentro del constructor la posición y el texto del botón "Volver"
  Botones volver = new Botones(width*0.4958, height*0.65,"Volver");
  
  //Mostramos el botón
  volver.display();
  //Ejecutamos el método tocarBoton()
  //Escribimos entre paréntesis la pantalla seleccionada
  volver.tocarBoton("menu");
  
}
