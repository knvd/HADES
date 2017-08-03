# HADES

A H-ybrid A-lgorithm E-ncryption S-ystem (HADES) implementing both DES (modified) and RSA.

[Name Background: Hades was the god of the UNDERWORLD in greek Mythology.(https://en.wikipedia.org/wiki/Hades)]
RSA is the most Secure Encryption Algorithm in the world as of now but Using RSA algorithm for data encryption is a time consuming process as it is 10x slower than normal DES. On the other hand DES or any Private key algorithm has the drawback of sharing of secret/key.

Our Hybrid Algorithm (HADES) uses RSA encryption to encrypt the private key of user and Applies normal round encryption to the data with round specific keys generated from the user private key. The result is that user do not need to worry about sharing of key, He/She can share the key over any unreliable medium or give it to anyone, Because No one in the world (as of now) can decrypt it except the user for whom it was encrypted. The RSA is not used for data encryption which gives an edge over the speed of process. 

On Decryption side User needs to provide the RSA-Encrypted key which is Decrypted and data is decrypted like the encryption process.
The user can choose mode of encryption [i.e ,Faster(4-rounds),Fast(8-rounds),Slow(12-rounds),Slower(16-rounds)] based on number of Rounds to be performed at the cost of time. The file must be decrypted using the same mode with which it was encrypted.

In the Dyanamic Implementation of this Algorithm, Each user is assigned a public key, which is shown on his homepage. However only the user has its 'd' and 'n' pair which means any file encrypted with the users public key can only be decrypted by that user.
