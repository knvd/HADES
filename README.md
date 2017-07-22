# HADES

A H-ybrid A-lgorithm E-ncryption S-ystem (HADES) implementing both DES (modified) and RSA.

Name Background: Hades was the god of the UNDERWORLD in greek Mythology(https://en.wikipedia.org/wiki/Hades).

RSA is a Secure Encryption algorithm but Using RSA algorithm for data encryption is a time consuming process a it is 10x slower than normal DES.On the other hand DES or any Private key algorithm has the drawback of sharing of secret/key.

This Hybrid Algorithm uses RSA enc. to encrypt the private key of user and Applies normal round encryption to the data with round specific keys generated from the user private key. On decryption User provides the RSA encrypted key which is decrypted and data is decrypted like the encryption process, which means we can simply shqre the encrypted key over unreliable channel. 
The user can choose no. of rounds to be performed at the cost of time. Currently the options include 2, 4 ,8, 12 and 16 rounds. 
As of now(18 Jul 2017), The Project includes 4 classes.
   
   1. start class: this class includes the main() function. In this class user gets a command line interface to choose     options.The five options include Encrypt a file, Decrypt a file, Open a file, Delete a file and Exit.
    
    2. EncDec class: This class includes 02 functions ,each for encryption and Decryption.
    
    3. FunctionSet class: This class includes the essential functions(like xor and shuffle) as well as other short utility functions.There are a total of 11 functions(*XOR function *Shuffle Function *file/DIR check function *Percentage function    *openfile function *deletefile function *shiftkey function *rounds function *EstimateTime function *CopyFile function *KeyGen Function).
    
    4. RsaFunctionClass: This Class Contains 06 Functions for RSA encryption: (* phi function* privatekey Function* modpow function* EncDec function* StringToBytes function* BytesToString function * WriteEncKey function)
