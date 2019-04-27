#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <time.h>
#include <unistd.h> 

#include "desfunct.h"
using namespace std;

int main(){

   static FILE *input, *output, *keyFile;
   unsigned long size;
   short int pad;
   char temp[10]="";
   //DES key set vars
   short int bytesWritten, processMode;
   unsigned long blockCount = 0, numberOfBlocks;
   unsigned char* dataBlock = (unsigned char*) malloc(8*sizeof(char));
   unsigned char* processedBlock = (unsigned char*) malloc(8*sizeof(char));
   keySet* keySets = (keySet*)malloc(17*sizeof(keySet));
   unsigned char* desKey = (unsigned char*) malloc(8*sizeof(char));

    int choice;
    printf("Please enter 1 or 0 if you want to generate a key or provide your own respectively. \n");
    cin >> choice;
    if(choice != 0 && choice !=1){
    	printf("Please enter a 1 or 0. \n");
        return 1;
    }
      if(choice == 1){
         printf("Generating key into key.txt\n");
         keyFile = fopen("key.txt","wb");
         if(!keyFile){
         	printf("error creating file");
            return 1;
         }
                short int bytesWritten;
		unsigned char* desKey = (unsigned char*) malloc(8*sizeof(char));
		//seed for random generator
		unsigned int seed = (unsigned int)time(NULL);
		srand (seed);

		keyGenerator(desKey);
		bytesWritten = fwrite(desKey, 1, 8, keyFile);
		fclose(keyFile);
      } //end key generator code 

    else if(choice == 0){
        printf("What is your key file? \n");
        scanf("%s", &temp);
        keyFile = fopen(temp,"r");
	if(keyFile==NULL){
	    printf("%s does not exist \n",temp);
	    return 1;
	}

	short int bytesRead;
	unsigned char* desKey = (unsigned char*) malloc(8*sizeof(char));
	bytesRead = fread(desKey, sizeof(unsigned char), 8, keyFile);
	if (bytesRead != 8) {
	      printf("Key needs to be 8 bytes \n");
	      fclose(keyFile);
	      return 1;
	}	
    }//end already have key check
 
         /*
		CREATES SUBKEYS
	*/
	subkeyGenerator(desKey, keySets);


     char choice2;
     printf("Do you want to encrypt or decrypt? (e/d) \n");
      cin >> choice2; 
       if(choice2 != 'e' && choice2 !='d'){
    	printf("Please enter an 'e' or 'd'. \n");
        return 1;
   	}

/*

	ENCRYPTION

*/

      if(choice2 == 'e'){
	printf("Please enter the plain text file to be encrypted. \n");
	scanf("%s", &temp);
	input = fopen(temp,"r");
	if(input==NULL){
	   printf("%s does not exist \n",temp);
	   return 1;
	}
         printf("The cipher will be put into cipher.txt \n");
	 output = fopen("cipher.txt","wb");
  
       //encrypt stuff
	processMode = 1;
        printf("Encrypting : \n");
    
	fseek(input, 0L, SEEK_END);
	size = ftell(input);

	fseek(input, 0L, SEEK_SET);
	
	if(size%8)
		numberOfBlocks = size/8 +1;
	else
		numberOfBlocks = size/8;


	while(fread(dataBlock,1,8,input)){
	     blockCount++;
	     if(blockCount == numberOfBlocks){
	        if (processMode == 1) {
	        pad = 8 - size%8;
		if(pad < 8){
		 memset((dataBlock + 8 - pad), (unsigned char)pad,pad);
		}//end pad<8

		desFunction(dataBlock, processedBlock, keySets, processMode);

		bytesWritten = fwrite(processedBlock, 1, 8, output);

            if (pad == 8){ // Write an extra block for padding
		memset(dataBlock, (unsigned char)pad, 8);
	        desFunction(dataBlock, processedBlock, keySets, processMode);
	        bytesWritten = fwrite(processedBlock, 1, 8, output);
	     }//end padding ==8
          }//end process_mode ==
           else{
		desFunction(dataBlock, processedBlock, keySets, processMode);
	        pad = processedBlock[7];
		if (pad < 8){
		bytesWritten = fwrite(processedBlock, 1, 8 - pad, output);
		}
	   }//end else 
	}//end if blockcount ==
	  else{ 
		desFunction(dataBlock, processedBlock, keySets, processMode);
		bytesWritten = fwrite(processedBlock, 1, 8, output);
	   }
	memset(dataBlock, 0, 8);
	
      }//end while
	
       }//end encryption choice

/*

	DECRYPTION

*/

        else if(choice2 == 'd'){
	printf("Please enter the cipher text file to be decrypted. \n");
	scanf("%s", &temp);
	input = fopen(temp,"r");
	if(input==NULL){
	   printf("%s does not exist \n",temp);
	   return 1;
	}

      printf("The decrypted cipher text will be put into cipherdecrypt.txt \n");
      output = fopen("cipherdecrypt.txt","wb");

	printf("Decrypting: \n");
	//decryption stuff
	processMode = 0;

	fseek(input, 0L, SEEK_END);
	size = ftell(input);

	fseek(input, 0L, SEEK_SET);
	if(size%8)
		numberOfBlocks = size/8 + 1;
	else
		numberOfBlocks = size/8;

	while(fread(dataBlock,1,8,input)){
	     blockCount++;
	     if(blockCount == numberOfBlocks){
	        if (processMode == 1) {
	        pad = 8 - size%8;
		if(pad < 8){
		 memset((dataBlock + 8 - pad), (unsigned char)pad,pad);
		}//end pad<8

		desFunction(dataBlock, processedBlock, keySets, processMode);

		bytesWritten = fwrite(processedBlock, 1, 8, output);

            if (pad == 8){ // Write an extra block for padding
		memset(dataBlock, (unsigned char)pad, 8);
	        desFunction(dataBlock, processedBlock, keySets, processMode);
	        bytesWritten = fwrite(processedBlock, 1, 8, output);
	     }//end padding ==8
          }//end process_mode ==
           else{
		desFunction(dataBlock, processedBlock, keySets, processMode);
	        pad = processedBlock[7];
		if (pad < 8){
		bytesWritten = fwrite(processedBlock, 1, 8 - pad, output);
		}
	   }//end else 
	}//end if blockcount ==
	  else{ 
		desFunction(dataBlock, processedBlock, keySets, processMode);
		bytesWritten = fwrite(processedBlock, 1, 8, output);
	   }//end else
	memset(dataBlock, 0, 8);
	
      }//end while

       }//end decrpytion choice
  
  return 0;

}//end main();
