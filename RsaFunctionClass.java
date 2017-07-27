 /*This Class Contains 05 Functions for RSA encryption::
	 * phi function
	 * privatekey Function
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
import java.util.Date;
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

		
		 // Compute the private key 'd' from Public key 'e' and phi		
	    private static BigInteger privateKey(BigInteger e, BigInteger phi) {
			
	    	BigInteger elocal = e;
	    	BigInteger philocal = phi;
	    	BigInteger xOld = new BigInteger("1");
	    	BigInteger yOld = new BigInteger("0");
	    	BigInteger x = new BigInteger("0");
	    	BigInteger y = new BigInteger("1");
	    	BigInteger xNew, yNew, q, r;
	    	BigInteger zero = new BigInteger("0");

	    	// Extended Euclidean algorithm
	    	while(!philocal.equals(zero))		//phi!=0 
	    	{
	    		q = elocal.divide(philocal);		//quotient=e/phi
	    		r = elocal.mod(philocal);			//remainder=e%phi
	    		xNew = xOld.subtract(q.multiply(x));	
	    		yNew = yOld.subtract(q.multiply(y));	
	    		elocal = philocal;				
	    		philocal = r;					
	    		xOld = x;						
	    		yOld = y;						
	    		x = xNew;
	    		y = yNew;
	    	}
	    	
	    	// We want d to be positive
	    	// if xOld is less than zero we add it to x else, we just return it
	    	if(xOld.compareTo(zero) == -1) {
	    		return xOld.add(x);
	    	}
	    	return xOld;
	    	
	        }
	    
	 
	 	// Do modular exponentiation for the expression c_m^e_dmodn=c_m -->for encryption use m, e And for dec use c,d 
	    // Can be used for encryption (with public key e) or decryption (with private key d).m stands for plain text and c for cipher text
	
	 	static public BigInteger EncDec(BigInteger m_c, BigInteger e_d, BigInteger n) 
	 	{
	 		BigInteger zero = new BigInteger("0");
	 		BigInteger one = new BigInteger("1");
	 		BigInteger two = one.add(one);

	 		// Base Case
	 		if (e_d.equals(zero))
	 			return one;				//m^e mod n-->e=0
	 		if (e_d.equals(one))
	 			return m_c.mod(n);		//m^e mod n-->e=1

	 		if (e_d.mod(two).equals(zero)) {
	 			// Calculates the square root of the answer
	 			BigInteger answer = EncDec(m_c, e_d.divide(two), n);
	 			// Reuses the result of the square root
	 			return (answer.multiply(answer)).mod(n);
	 		}	

	 		return (m_c.multiply(EncDec(m_c,e_d.subtract(one),n))).mod(n);
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
		String returnname="",name="";
		filename=filename.substring(filename.lastIndexOf("/")+1);	
		if (filename.contains("."))
			name="Key-"+filename.substring(0,filename.lastIndexOf("."))+".txt";
		else
			name="Key-"+filename+".txt";
		
		
		Date dt=new Date();
		try 
		{
			File ptr=new File(dirname+"/"+name);
			if(ptr.exists())
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+"Key-"+filename.substring(0,filename.lastIndexOf("."))+"Copy"+".txt","rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+" Generated on: "+dt+"\n\nNote: This is NOT the Secret(private) Key, but Just the RSA Encrypted Cipher text\nNo Need To keep It a secret:)\n\n"+Enkey);	
				out.close();
				returnname=dirname+"/"+"Key-"+filename.substring(0,filename.lastIndexOf("."))+"Copy"+".txt";
			}
			else
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+name,"rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+" Generated on: "+dt+"\n\nNote: This is NOT the Secret(private) Key, but Just the RSA Encrypted Cipher text\nNo Need To keep It a secret:)\n\n"+Enkey);	
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
