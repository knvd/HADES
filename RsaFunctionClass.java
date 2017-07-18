 /*This Class Contains 06 Functions for RSA encryption::
	 * phi function
	 * privatekey Function
	 * modpow function
	 * EncDec function
	 * StringToBytes function
	 * BytesToString function
	 * WriteEncKey function
	 */	
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.math.BigInteger;
import java.nio.charset.Charset;
//import java.util.Random;

public class RsaFunctionClass {
	/*USE THIS SEGMENT OF CODE IF DEPLOYING ON DYANAMIC SYSTEM
	 * Randomly generates Primes 'p','q'and'e' of indicated length--
	 * static private int LENp = 1000;		//latest systems use between 1000-1024bits each for p and q which means 2024bits for n
	 * static private int LENq = 990;
	 * static private int LENe = 1010;		//must be >p and q but<p+q
	 * static private Random rand =new Random();
	 * static BigInteger p = BigInteger.probablePrime(LENp, rand);		//get random prime no For 
	 * static BigInteger q = BigInteger.probablePrime(LENq, rand);		//get random prime no of length LENq
	 * static BigInteger e = BigInteger.probablePrime(LENe, rand);		//get random prime no of length LENe
	 * 
	 */

	//For ENC. and Dec. at static environment 
	static BigInteger p=new BigInteger("10170520018816060002239198020646063617440813963683806542633752937862542648364136045917499030105022294024748804238597402254039985100236404965190482708142187368697889253048207221223624582229342521261263408791744763793516074597040299901138703006171350895659687883491657934523458832379876478944697004728249");
	static BigInteger q=new BigInteger("6538485182967967681002944134671339894206673047620489057461415934169800822166879906242455231033714540721877707612120116659739833129418193152002075999608967662199243849099987582866554555609201752006138373531748395312746018907257771132455712299919934506048310864324009318877056820609330530982612021213");	
	static BigInteger e=new BigInteger("6828972640182135118746016131596780415865452604497990610085654097728892288639537523547809894460234960988728723963025831952602723628800061138399926625059315680994307324761730407117476094186887790860255691652271759632373671008310448893399963176826806453367498895202162462213762974300039819212045848589714261");
	static BigInteger n = p.multiply(q);
	static BigInteger phi=phi(p,q);
	static BigInteger d = privateKey(e, phi);


	    		//Calculate phi(p,q)=(p-1)(q-1)
	static public BigInteger phi(BigInteger p,BigInteger q)
			{
				     BigInteger pMinusOne=p.subtract(BigInteger.ONE);		//p-1
				     BigInteger qMinusOne=q.subtract(BigInteger.ONE);		//q-1
				     phi=pMinusOne.multiply(qMinusOne);						//phi=(p-1)(q-1)
				     return phi;
	   		}

		
		 // Compute the private key 'd' from Public key 'e' and phi(n).		NEWWWWW
	    private static BigInteger privateKey(BigInteger e, BigInteger phi) {
			
	    	BigInteger elocal = e;
	    	BigInteger philocal = phi;
	    	BigInteger sOld = new BigInteger("1");
	    	BigInteger tOld = new BigInteger("0");
	    	BigInteger s = new BigInteger("0");
	    	BigInteger t = new BigInteger("1");
	    	BigInteger sNew, tNew, q, r;
	    	BigInteger zero = new BigInteger("0");

	    	// Extended Euclidean algorithm
	    	while(!philocal.equals(zero))		//phi!=0 
	    	{
	    		q = elocal.divide(philocal);		//quotient=e/phi
	    		r = elocal.mod(philocal);			//remainder=e%phi
	    		sNew = sOld.subtract(q.multiply(s));	// 	1-(quotient*0)
	    		tNew = tOld.subtract(q.multiply(t));	// 0-(quotient*1)
	    		elocal = philocal;				//e=phi
	    		philocal = r;					//phi=remainder
	    		sOld = s;						//0
	    		tOld = t;						//1
	    		s = sNew;
	    		t = tNew;
	    	}
	    	
	    	// We want d to be positive
	    	// if sOld is less than zero we add it to s
	    	// else, we just return it
	    	if(sOld.compareTo(zero) == -1) {
	    		return sOld.add(s);
	    	}
	    	return sOld;
	    	
	        }
	    
	 
	 	// Do modular exponentiation for the expression b^e mod m
	 	// (b to the power e, modulo m).
	 	static private BigInteger modpow(BigInteger b, BigInteger e, BigInteger m) {
	 		// prints the calculations
	 		// System.out.println(b + " " + e + " " + m);
	 		BigInteger zero = new BigInteger("0");
	 		BigInteger one = new BigInteger("1");
	 		BigInteger two = one.add(one);

	 		// Base Case
	 		if (e.equals(zero))
	 			return one;
	 		if (e.equals(one))
	 			return b.mod(m);

	 		if (e.mod(two).equals(zero)) {
	 			// Calculates the square root of the answer
	 			BigInteger answer = modpow(b, e.divide(two), m);
	 			// Reuses the result of the square root
	 			return (answer.multiply(answer)).mod(m);
	 		}	

	 		return (b.multiply(modpow(b,e.subtract(one),m))).mod(m);
	 	}
	 	
	 
	    
	    
	    // Can be used for encryption (with public key e) or decryption (with private key).
	 	static public BigInteger EncDec(String key, BigInteger e_d) 
	 	{
	 			//REMINDER--make regex to accept only no. sequence of key to be accepted;;use key.matches()
	 		
	 		BigInteger cmessage=new BigInteger(key);
	 		return modpow(cmessage, e_d, n);
	 	}

	public static String StrToBytes(String key)
	 	{
	 		byte[] bytekey =key.getBytes(Charset.defaultCharset());
	 		key="";
			for(int i=0;i<bytekey.length;i++)
				{
					byte b=bytekey[i];	
					key+=b;			//cancatenate bytes	
				}
	 		return key;
	 	}

	
	public static String BytesToStr(byte [] bkey)
	{
		String Skey =new String(bkey,Charset.defaultCharset());	
		return Skey;
	}
	

	public static String WriteEncKey(BigInteger Enkey,String dirname,String filename)
	{
		filename=filename.substring(filename.lastIndexOf("/")+1);	
		String name="Key-"+filename.substring(0,filename.lastIndexOf("."))+".txt";
		String returnname="";
		
		
		try 
		{
			File ptr=new File(dirname+"/"+name);
			if(ptr.exists())
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+"Key-"+filename.substring(0,filename.lastIndexOf("."))+"Copy"+".txt","rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+"\n"+Enkey);	
				out.close();
				returnname=dirname+"/"+"Key-"+filename.substring(0,filename.lastIndexOf("."))+"Copy"+".txt";
			}
			else
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+name,"rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+"\n"+Enkey);	
				out.close();
				returnname=dirname+"/"+name;
			}
	
	} catch (IOException e) {
		System.out.println(e);
		//e.printStackTrace();
		}
	return returnname;
	}

}
