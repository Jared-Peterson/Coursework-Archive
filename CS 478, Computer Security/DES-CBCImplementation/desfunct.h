#ifndef DESFUNCT_H
#define DESFUNCT_H

typedef struct {
	unsigned char k[8];
	unsigned char c[4];
	unsigned char d[4];
} keySet;

void keyGenerator(unsigned char* key);
void ivGenerator(unsigned char* iv);
void subkeyGenerator(unsigned char* mainKey, keySet* keySets);
void desFunction( unsigned char* messagePiece, unsigned char* processedPiece, keySet* keySets, int mode);

#endif
