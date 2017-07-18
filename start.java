
import java.math.BigInteger;
import java.util.Scanner;

public class start {
	static boolean flag=true;
	static String filename="",dirname="",key="";
	static int chk=0,ch=0;
	//static byte [] bkey;
 
	public static void main(String[] args) {
		EncDec obj=new EncDec();
		Scanner chscanner =new Scanner(System.in);		
		
		while(flag)
		{
		 System.out.println("\n===============================================================\n 1.ENCRYPT a file \t 2.DECRYPT a file \t 3.Open a File\n 4.Delete a File \t 5.Exit Program\n===============================================================");
		 System.out.println("Enter Your Choice:\t");
		 	if(chscanner.hasNextInt())
			    ch=chscanner.nextInt();
		 switch(ch)
		  {
		    case 1:
		    	do {
		    	System.out.println("Enter Name of the File to be Encrypted(include path if outside):");				
				filename=chscanner.next();
				chk=FunctionSet.check(filename);
				
				}while(chk!=1);
					
				do {
				System.out.println("Enter Name of Directory to store Encrypted file:");				
				dirname=chscanner.next();
				chk=FunctionSet.check(dirname);
				}while(chk!=2);
						
				do{
				System.out.println("Enter Your Private Key (length>16), REMEMBER it for Decryption:");
				key=chscanner.nextLine();
				if(key.length()<16)
					System.out.println("\t\t--Private Key Size should be > 10!--");
				}while(key.length()<10);
				
				//bkey=key.getBytes(Charset.defaultCharset());  //array of bytes of key
				key=RsaFunctionClass.StrToBytes(key);	//get the string of bytes
				BigInteger Enkey=RsaFunctionClass.EncDec(key, RsaFunctionClass.e);	//RSA-Encrypt the key
				String keyloc=RsaFunctionClass.WriteEncKey(Enkey, dirname, filename);	//write encrypted key to file for further use
				
				obj.encrypt(filename,dirname,key);
					
				System.out.println("\nFile ENCRYPTED Successfully as 'enc.txt', Stored at"+"'"+dirname+"'");
				System.out.println("ATTENTION! NOW Your Encrypted Private Key is:"+Enkey+"\n\tIt is Saved for You at '"+keyloc+"'");
		    	break;		
		    	
		    case 2: 
		    	do
				{
				System.out.println("Enter Name of the Encrypted File that is to be Decrypted(include path if outside):");				
				filename=chscanner.next();
				chk=FunctionSet.check(filename);
				}while(chk!=1);

				//Get Original Extension for Decryption
				System.out.println("Enter EXTENSION to which file is to be Decrypted(e.g txt,pdf,jpg,mp3,mp4,etc):");
				String extname = chscanner.next();
				extname=extname.substring(extname.lastIndexOf(".") + 1);	//if user provided a '.' with extension
			  
				do{
				System.out.println("Enter Name of Directory where Decrypted file will be Stored:");				
				dirname=chscanner.next();
				chk=FunctionSet.check(dirname);
				}while(chk!=2);
					
				do{
				System.out.println("Enter Your Encrypted Private Key of the file:");
				key=chscanner.nextLine();
				if(key.length()<16)
				System.out.println("\t\t--Key Size must be > 500!");
				}while(key.length()<500);
		
				BigInteger Deckey=RsaFunctionClass.EncDec(key, RsaFunctionClass.d);	//UNHANDLED>> make regex seq for key in EncDec fxn 
				//key=RsaFunctionClass.BytesToStr(bkey);	//DEV..F
				//System.out.println("Decrypted Private key is:"+key);			
				key=Deckey.toString();
				obj.decrypt(filename,extname,dirname,key);	
				System.out.println("\nFile DECRYPTED Successfully as 'dec."+extname+",' Stored at "+"'"+dirname+"'");
	    		break;
		    	
		   	case 3:
		   		do{
		   		System.out.println("Enter Name of the File to be opened:");		
		   		filename=chscanner.next();
		   		chk=FunctionSet.check(filename);
		   		}while(chk!=1);
		    			
		   		FunctionSet.openfile(filename);		//Static Call
		   		break;
		    	
	   		case 4:
		   		System.out.println("Enter the name of the file you want to delete:");
		   		String fname=chscanner.next();
		   		System.out.println("Do you want to delete the "+fname+" file! \nEnter 1 to Confirm and 2 to Abort:");
				int opt=0;
				if(chscanner.hasNextInt())
					opt=chscanner.nextInt();
				FunctionSet.delencf(fname,opt);
				break;
		    		
	   		case 5:
		 		flag=false;
		  		System.out.println("Good Bye!");	
		   		chscanner.close();
		   		break;
		    			
			default:
	  			flag=false;
	  			System.out.println("No Such Option... Good Bye!");	
	   			chscanner.close();
		   	}	
		}	
	}
}
