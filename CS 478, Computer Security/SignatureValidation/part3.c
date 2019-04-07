#include "part3.h"

static FILE *ourPublicKey, *decryptedSessionKey, *cipherText, *signature;

int main(int argc, char * argv[]){
	//example run input
	//./part3 -Public pubkey.pem -DecryptedSessionKey decryptedSessionKey.txt -Cipher cipher.txt -Signature signature.txt
	//reading files
	int counter=0;
	while(counter < argc){
		if(strcmp(argv[counter],"-Public") == 0){
			ourPublicKey = fopen(argv[counter+1],"r");
			if(ourPublicKey == NULL){
				printf("Could not open file %s for reading.\n",argv[counter+1]);
				exit(1);
			}
			counter++;
		}
		else if(strcmp(argv[counter],"-DecryptedSessionKey") == 0){
			decryptedSessionKey = fopen(argv[counter+1],"r");
			if(decryptedSessionKey == NULL){
				printf("Could not open file %s for reading.\n",argv[counter+1]);
				exit(1);
			}
			counter++;
		}
		else if(strcmp(argv[counter],"-Cipher") == 0){
			cipherText = fopen(argv[counter+1],"r");
			if(cipherText == NULL){
				printf("Could not open file %s for reading.\n",argv[counter+1]);
				exit(1);
			}
			counter++;
		}
		else if(strcmp(argv[counter],"-Signature") == 0){
			signature = fopen(argv[counter+1],"r");
			if(signature == NULL){
				printf("Could not open file %s for reading.\n",argv[counter+1]);
				exit(1);
			}
			counter++;
		}
		else if(strcmp(argv[counter],"./part3") == 0){
		}
		else{
			printf("Error: bad parameter.\n");
			exit(1);
		}
		counter++;
	}//end of while
	
	//decrypting cipher.txt with hex key from decryptedSessionKey.txt and hex iv from iv.txt into decryptedCipher.txt
	system("openssl enc -d -des-cbc -nosalt -K 62a66606aa5cf636 -iv 7748eaf925f7c106 -in cipher.txt -out decryptedCipher.txt");
	printf("Decrypted ciphertext printed to decryptedCipher.txt\n");
	
	//printing plaintext
	printf("The plaintext is: \n");
	static FILE *decryptedCipher;
	decryptedCipher = fopen("decryptedCipher.txt", "r");
	if(!decryptedCipher){
		printf("Error reading decryptedCipher.txt.\n");
		exit(1);
	}
	char file = fgetc(decryptedCipher);
	while(file != EOF){
		printf("%c", file);
		file = fgetc(decryptedCipher);
	}
	
	//verifying signature
	if(VerifySignature() == 1){
		printf("Signature authentication confirmed.\n");
	}
	else{
		printf("Signature authentication failed.\n");
	}
	
	//closing files
	fclose(cipherText);
	fclose(decryptedSessionKey);
	fclose(signature);
	fclose(ourPublicKey);
	fclose(decryptedCipher);
	return 0;
}//end main

int VerifySignature(void){

	EVP_PKEY_CTX *ctx;
	unsigned char *md, *sig;
	size_t mdlen, siglen;
	EVP_PKEY *verify_key;
	
	//setting up mdlen and siglen
	fseek(cipherText, 0, SEEK_END);
	mdlen = ftell(cipherText);
	fseek(cipherText, 0, SEEK_SET);
	
	fseek(signature, 0, SEEK_END);
	siglen = ftell(signature);
	fseek(signature, 0, SEEK_SET);

	//setting up md and sig
	md = (char *)malloc(mdlen+1);
	fread(md, mdlen, 8, cipherText);
	
	sig = (char *)malloc(siglen+1);
	fread(sig, siglen, 8, signature);
	
	//setting up verify_key
	verify_key = PEM_read_PUBKEY(ourPublicKey, NULL, NULL, NULL);

	/*
	* NB: assumes verify_key, sig, siglen md and mdlen are already set up
	* and that verify_key is an RSA public key
	*/
	ctx = EVP_PKEY_CTX_new(verify_key, NULL);
	if (!ctx){
		printf("ERROR: not ctx\n");
		exit(1);
	}
	if (EVP_PKEY_verify_init(ctx) <= 0){
		printf("ERROR: EVP_PKEY_verify_init(ctx) <= 0\n");
		exit(1);
	}
	if (EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_PADDING) <= 0){
		printf("ERROR: EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_PADDING) <= 0\n");
		exit(1);
	}
	if (EVP_PKEY_CTX_set_signature_md(ctx, EVP_sha256()) <= 0){
		printf("ERROR: EVP_PKEY_CTX_set_signature_md(ctx, EVP_sha256()) <= 0\n");
		exit(1);
	}

	//ret == 1 is succes, 0 failure, and < 0 for other error
	int ret;
	ret = EVP_PKEY_verify(ctx, sig, siglen, md, mdlen);
	
	//free
	free(md);
	free(sig);
	
	return ret;

}//end VerifySignature()
