package hadesED;
 /*This Class Contains Functions for RSA encryption::
	 * phi function
	 * privatekey Function
	 * EncDec function
	 * StringToBytes function
	 * BytesToString function
	 * WriteEncKey function
	*EdGen function
	 */	
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.math.BigInteger;
import java.util.Date;
import java.util.Random;
import java.sql.*;


public class RsaFunctionClass {

	    		//Calculate phi(p,q)=(p-1)(q-1)
	static public BigInteger phi(BigInteger p,BigInteger q)
			{
				     BigInteger pMinusOne=p.subtract(BigInteger.ONE);		//p-1
				     BigInteger qMinusOne=q.subtract(BigInteger.ONE);		//q-1
				     BigInteger phi=pMinusOne.multiply(qMinusOne);						//phi=(p-1)(q-1)
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
	 	

	public static String WriteEncKey(BigInteger Enkey,BigInteger e,String dirname,String filename,int rounds)
	{
		database dobj=new database();
		String returnname="",name="";
		filename=filename.substring(filename.lastIndexOf("/")+1);	
		if (filename.contains("."))
			name="CipherKey-"+filename.substring(0,filename.lastIndexOf("."))+".txt";
		else
			name="CipherKey-"+filename+".txt";
		
		//get the user name against e from db
		ResultSet rs;
		String unm="";
		try {

		if(!dobj.connect("localhost","HADES","root","toor"))
			System.out.println("\nError Connecting to Database");
			rs=dobj.select("select uname from members where e='"+e+"';");
			while(rs.next())
				{
				unm=rs.getString("uname");
				
				}
		
		} catch (SQLException e1) {
			e1.printStackTrace();
		}	 
		
		
		Date dt=new Date();
		try 
		{
			File ptr=new File(dirname+"/"+name);
			if(ptr.exists())
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+"Copy-"+name,"rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+" Generated on: "+dt+"\n\nMode Used:'"+rounds+"'\\n\nNote: This is NOT the Secret(private) Key, but Just the RSA Encrypted Cipher text, No Need To keep It a secret:)\n\nEncrypted Key:\n"+Enkey+"\n\nEncrypted for the user '"+unm+"' using the following Public Key:\n"+e);	
				out.close();
				returnname=dirname+"/"+"Copy-"+name;
			}
			else
			{
				RandomAccessFile out=new RandomAccessFile(dirname+"/"+name,"rw");
				out.seek(0);
				out.writeBytes("Encrypted Key for File : "+filename+" Generated on: "+dt+"\n\nMode Used:'"+rounds+"'\n\nNote: This is NOT the Secret(private) Key, but Just the RSA Encrypted Cipher text, No Need To keep It a secret:)\n\nEncrypted Key:\n"+Enkey+"\n\nEncrypted for the user '"+unm+"' using the following Public Key:\n"+e);	
				out.close();
				returnname=dirname+"/"+name;
			}
	
	} catch (IOException ex) {
		System.out.println(ex);
		//e.printStackTrace();
		}
	return returnname;
	}
	
public static void e_dGen(String uname)
{
	database dobj=new database();
	int LENp = 1000;		//latest systems use between 1000-1024bits each for p and q which means 2024bits for n
	int LENq = 990;
	int LENe = 1010;		//must be >p and q but<p+q
	Random rand =new Random();
	BigInteger p = BigInteger.probablePrime(LENp, rand);		//get random prime no For 
	BigInteger q = BigInteger.probablePrime(LENq, rand);		//get random prime no of length LENq
	BigInteger e = BigInteger.probablePrime(LENe, rand);
	BigInteger n = p.multiply(q);
	BigInteger phi=phi(p,q);
	BigInteger d=RsaFunctionClass.privateKey(e,phi);

	String pubkey="";
	ResultSet rs;
	
	try {
		if(!dobj.connect("localhost","HADES","root","toor"))
			System.out.println("\nError Connecting to Database");

		rs=dobj.select("select e from members where uname='"+uname+"';");
		while(rs.next())
			{
			pubkey=rs.getString("e");
			
			}
	
	} catch (SQLException e1) {
		e1.printStackTrace();
	}	 
	if(pubkey.equals("0"))		//no second time public key generation
		dobj.insert("UPDATE members SET e='"+e+"',d='"+d+"',n='"+n+"' WHERE uname='"+uname+"';");
	
}
	
}
