# DES-CBC Implementation

These files implement the DES-CBC cipher to encrypt and decrypt a file using either a supplied key and IV 
or a randomly generated key and IV using C++. This DES-CBC implementation only works in and of itself.

## Prerequisites

Software required to run these files are: C++ Compiler.

## How to Use

How to compile.

```
make
```

Example use of this program with given files.

```
./part2
```

Please enter 1 or 0 if you want to generate a key or provide your own respectively.

```
1
```

Generating key into key.txt

Do you want to encrypt or decrypt? (e/d)

```
e
```

Please enter the plain text file to be encrypted.

```
plain.txt
```

The cipher will be put into cipher.txt

```
./part2
```

Please enter 1 or 0 if you want to generate a key or provide your own respectively.

```
0
```

What is your key file?

```
key.txt
```

Do you want to encrypt of decrypt? (e/d)

```
d
```

Please enter the cipher text file to be decrypted.

```
cipher.txt
```

The decrypted cipher text will be put into cipherdecrypt.txt
