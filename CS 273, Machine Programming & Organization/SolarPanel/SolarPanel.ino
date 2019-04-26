//
// Assembly functions
//
extern "C" {

   void initializePanel();
   void operatePanel();
   void resetPanel();
   void parkPanel();
   int queryPanel(byte lightVals[]);
   byte lightVal1;
   byte readAD(byte);

}

//
// If there is any serial input, read it into the
// given array; the array MUST be at least 32 chars long
// - returns true if a string is read in, false otherwise
// (note: 9600baud (bits per second) is slow so we need
//  to have delays so that we don't go too fast)
//
boolean readUserCommand(char cmdString[])
{
   if (!Serial.available())
      return false;
   
   delayMicroseconds(5000); // allow serial to catch up
   
   int i=0;
   while (i < 31) {
      
      cmdString[i++] = Serial.read();
      delayMicroseconds(1000);

      if (!Serial.available())
         break; // quit when no more input

   }//end while i<31
   
   cmdString[i] = '\0'; // null-terminate the string

   while (Serial.available()) {

      Serial.read(); // flush any remain input (more than 31 chars)
      delayMicroseconds(1000);

   }//end while serial.available

   return true;

}//end readUserCommand

volatile uint8_t ct = 0;
volatile uint8_t lightVals[25];

ISR (TIMER1_COMPA_vect){

  arrayAdd();
 
}


void initTimer(){

  noInterrupts();
  DDRB |= 1<<PINB0;
  TCCR1A = 0; TCCR1B = 0; TCNT1 = 0;
  TCCR1B |= 1<<CS10 | 1<<CS12 | 1<< WGM12;
  TIMSK1 |= 1<<OCIE1A;
  OCR1A = 390600;
  interrupts();
  
}

void arrayAdd(){

  byte v;
  
  v = readAD(1); 

  if(ct<25){
    
      lightVals[ct] = v;
      ct++;
          
  }

}

//
// Code that uses the functions
//
void setup()
{

   Serial.begin(9600);
   initializePanel();
   initTimer();

}

//
// In order to process user command AND operate the
// solar panel, the loop function needs to poll for
// user input and then invoke "operatePanel" to allow
// the panel operation code to do what it needs to 
// for ONE STEP. You should not do a continuous loop
// in your assembly code, but just cycle through
// checking everything you need to one time, and then
// returning back and allowing the loop function here
// continue.
//
void loop()
{

   char cmd[32];
   int i = 0;
   int x = 0;
   int total = 0;
  
   delayMicroseconds(100); // no need to go too fast

   cmd[0] = '\0'; // reset string to empty
   if (readUserCommand(cmd)) {

      // this if statement just shows that command strings
      // are being read; it serves no other useful purpose
      // and can be deleted or commented out
      Serial.print("User command is (");
      Serial.print(cmd);
      Serial.println(")");

   }

   // The conditions below recognize each individual
   // command string; all they do now is print, but you
   // will need to add code to do the proper actions
   if (!strcmp(cmd,"reset")) {

      Serial.println("Do reset!");

      for(i = 0; i < 25; i++){
         lightVals[i] = 0;
      } 
      
      resetPanel(); 
       
      Serial.println("Done");

   } else if (!strcmp(cmd,"park")) {

      Serial.println("Do park!");
      parkPanel();
      Serial.println("Done");

   } else if (!strcmp(cmd,"query")) {

      Serial.println("Do query!");
      
      for(x = 0; x < 25; x++){

        if(lightVals[x] > 0){

        Serial.print("The sensor average is ");
        Serial.println(lightVals[x], DEC);

        }

        total = total + lightVals[x];

      }

      Serial.print("The total of the sensor values is ");
      Serial.println(total, DEC);
      
   }

   // This invokes your assembly code to do ONE STEP of
   // operating the solar panel

   operatePanel();

}



