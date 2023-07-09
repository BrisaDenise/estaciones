
//Muestra la cortina de Otoño
void cortinaOtono()
{
  //Creamos un nuevos objeto de la clase Cortinas para visualizar la cortina de Otoño
  Cortinas otono = new Cortinas("Otoño");
  otono.display();
}




//Creamos la clase Hojas que contendrá propiedades y métodos de las hojas del árbol de OTOÑO
class Hojas
{
  
  //Establecemos dos variables float donde se guardarán posiciones X e Y
  float posx, posy;
  //Con este string se determinará que tipo de hoja dibujar: izquierda o derecha
  String tipo;
  
  
  //Creamos un constructor para introducir el tipo de hoja y las posiciones X e Y para cada hoja creada
  Hojas(String tipo_hoja,float x, float y)
  {
    //Las asignamos a su respectivo equivalente dentro de la clase
    posx = x;
    posy = y;
    tipo = tipo_hoja;
  }
  
  
  //Creamos el método display para dibujar cada hoja del árbol
  void display()
  {
    //Preguntamos qué tipo de hoja es la pedida para dibujarla en las posiciones dadas
    
    //En el caso de ser la derecha, se dibujará la imagen hoja_derecha
    if (tipo == "derecha"){image(hoja_derecha,posx,posy);}
    
    //En el caso de ser la izquierda, se dibujará la imagen hoja_izquierda
    else if (tipo == "izquierda"){image(hoja_izquierda,posx,posy);}
  }
  
  
  //Con este método, la hoja caerá
  void tirarHoja()
  {
      //Con un FOR se recorre todo el array boolean que contine los "switches" para tirar una hoja = que_hoja []
      for (int i=0 ; i<25; i++)
      {
        //Se pregunta a cada índice del array si se ha puesto en TRUE
        //Recordemos que al ser tocado por el mouse, se transforma en TRUE el boolean correspondiente a la posición de mouseX e mouseY
        if (que_hoja[i])
        {
          //Como se trabajará que las hojas caigan, utilizaremos las posiciones Y
          //En nuestro array bidimensional todas las posición en Y tiene un 1 en su segundo índice = [x][1] 
          //Entonces, lo único que tendremos que variar es el primer índice, para ello utilizaremos la variable del for = i
          //El for recorrerá cada índice del array boolean del 0 al 24 (25 hojas)
          //Cuando se lo identifique, comenzará a agregarlo +2 a su posición en Y, haciendo que la hoja descienda
          
          pos_hojas[i][1] += 2;
          
          //Una vez que la hoja llegue a una posición random calculada entre dos valores ("ancho del suelo")
          //que_hoja[i] será igual a FALSE, haciendo que la hoja detenga su descenso
          //Y se sumará +1 al contador de hojas (que nos permitirá pasar a la próxima escena)
          if(pos_hojas [i][1] > random(height-100, height-5)) {que_hoja [i] = false; hojas++;}
        }
      }
   }
  
}
  



//Muestra la escena Otoño
void otono()
{ 
  //Ubicamos la imágen de fondo responsive a la pantalla
  image(otono_fondo,0,0,width,height);
  
  
  //Creamos un objeto de la clase atajos para poder hacer uno de menú. Les asignamos sus correspondientes eventos
  Atajos volver_menu = new Atajos(20,20,2);
  volver_menu.display();
  volver_menu.menu();
  
  //Creamos otro objeto de la clase atajos para poder hacer uno de avanzar que nos lleve a la siguiente escena INVIERNO con su correspondiente cortina
  //Esto es en caso de que no se pueda terminar la escena
  Atajos avanzar = new Atajos(width*0.965,20,1);
  avanzar.display();
  avanzar.accion();
  
  
  //Creamos un objeto de la clase Frase para mostrar la fase "acertijo" correspondiente de la escena 
  Frase f_otono = new Frase ("... solo una caricia", "podría derribar ...");
  f_otono.display();
  
  
  
  //Creamos un array de hojas con un total de 25 objetos = 25 hojas
  Hojas [] otono;
  otono = new Hojas [25];
  
  //Con este primer ciclo FOR creamos todas las hojas orientadas a la izquierda
  //Les pasamos las ubicaciones asignadas a cada índice del array bídimensional
  for(int i=0; i<14; i++)
  {
    otono[i]= new Hojas ("izquierda",pos_hojas [i][0], pos_hojas [i][1]);
    
    //Asignamos los métodos de la clase Hojas
    otono[i].display();
    otono[i].tirarHoja();
  }
  
  //Con este segundo ciclo FOR creamos todas las hojas orientadas a la derecha
  //Les pasamos las ubicaciones asignadas a cada índice del array bídimensional
  for (int j=14; j<25; j++)
  {
    otono[j]= new Hojas ("derecha",pos_hojas [j][0], pos_hojas [j][1]);
    
    //Asignamos los métodos de la clase Hojas
    otono[j].display();
    otono[j].tirarHoja();
  }
  
  
  
  //Con los siguientes condicionales se buscará deterctar cuando el mouse pase por encima de la hoja (la "acaricie") para que se caiga
  
  //Con un ciclo FOR se recorre todo el array bidimensional de las hojas
  for (int i=0; i<25; i++)
      {
        //En cada posición, se verifica si el mouse ha pasado por encima
        if (mouseX > pos_hojas [i][0] && mouseX< pos_hojas [i][0]+ 27 && mouseY > pos_hojas [i][1] && mouseY < pos_hojas [i][1]+25) 
        {
          //Y si la posición de la hoja en Y es mayor a height-100
          //Esto evita que se pueda volver a pasar el mouse sobre la hoja una vez en el suelo
          if(pos_hojas [i][1] < height-100)
          {
            if (!que_hoja[i])
            {
            //De haberlo, se disparan los sonidos del viento y la hoja
            viento.trigger();
            hoja.trigger();
            
            //Se pone en true la hoja que debe caer, es decir, se habilita a la hoja a caer
            que_hoja [i] = true;
            }
          }
        }
      }
  
  
  //Cuando hojas sea igual a 25 (total de las hojas en el árbol), pasaremos a la siguiente pantalla : la cortina de invierno.
  if (hojas == 25) {paso_estacion = true;}
}
