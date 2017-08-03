package hadesED;
/* This Class Contains :
	 * XOR function
	 * Shuffle Function
	 * shiftkey function
	 * rounds function
	 * CopyFile function
	 * KeyGen functions
	 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.util.Random;
import java.util.Scanner;

public class FunctionSet {
	Scanner inscan=new Scanner(System.in);
		
	public static void xor(RandomAccessFile in,RandomAccessFile temp,String key)
		{

		int len_var=0;
			try
			{
				long incount=in.length();
				in.seek(0);
				temp.seek(0);
				for(int j=0; j<=incount-1;j++)
				{
					int intchr=in.read();
							//write at beginning
					temp.write(intchr^key.charAt(len_var));
								
					len_var++;		
						if(len_var>key.length()-1)		
							len_var=0;
				}
			}
			catch(Exception e){
							
			}
		}


	public static void shuffle(RandomAccessFile in,RandomAccessFile out)
		{
		
		try {
			int p=0;
			long count=in.length();

			for(long i=count-1;i>=0;i--)	
				{
				    //Writing on file>>
				 	in.seek(i);		//set cursor of in file at last >> i=count-1
					out.seek(p);		//set cursor of output file to start >> p=0
					int ch =in.read(); //read() from in
					out.write(ch);		//write it at start of output file				
					p=p+1;				//increment p
					
				}
		} catch (IOException e) {
			System.out.println(e); 	
		}
	 	
		
		}



public static String shiftKey(String key,int shiftby)		//left shift by factor "shiftby'
{
	
	int keylen=key.length();
	String s1=key.substring(shiftby,keylen);
	String s2=key.substring(0,shiftby);
	key=s1+s2;
	return key;
}

public static void rounds(RandomAccessFile in,RandomAccessFile out,String key,int shiftby,int round)		//round Encryption/decryption
{
	
	if(key.length()%2!=0)
			round--;

		for(int i=1;i<=round;i++)		//Apply Alternate rounds
			{
			
				if(i%2!=0)
				{
					//System.out.println("\t\t\tROUND--"+i);
					key=FunctionSet.shiftKey(key,shiftby);
					FunctionSet.xor(in, out, key);		
				}
				else
				{
					//System.out.println("\t\t\tROUND--"+i);
					key=FunctionSet.shiftKey(key,shiftby);
					FunctionSet.xor(out, in, key);
				}	
			}
		

}



public static void copyFile(String source, String dest) throws IOException 			//using File channel=>faster method
{
	File src=new File(source);
	File dst=new File(dest);
    FileChannel sourceCh = null;
    FileChannel destCh = null;
    try {
    	sourceCh = new FileInputStream(src).getChannel();
    	destCh = new FileOutputStream(dst).getChannel();
        destCh.transferFrom(sourceCh, 0, sourceCh.size());

        
       } 
    finally{
    	sourceCh.close();destCh.close();
    }    
}

public static String KeyGen(String key)	//make a 200 byte key from user key
{
	int len=key.length(),i=0,n=1;
	
		
	do{		
		int x= key.charAt(i)+n;			//more randomness by 'n'
		key+=x;
		n++;i++;
		
		if(i==len-1)
			i=0;
	}while(key.length()<len+100);
	key=key.substring(len, key.length());
	
	int [] kArray=new int[key.length()];
	for(int m =0;m<=key.length()-1;m++)
	{
		kArray[m]=key.charAt(m);
	}

	int kArrLen=kArray.length;
	for (int j = kArrLen - 1; j >= 1; j--)		//FISHER-YATES Random Shuffle
	{
		Random rand = new Random();
		// generate a random number k such that 0 <= k <= j
		int k = rand.nextInt(j + 1);

		// swap current element with randomly generated index
		int temp = kArray[j];
		kArray[j] = kArray[k];
		kArray[k] = temp;
		
	}
	
	key="";
	for(int m =0;m<=kArrLen-1;m++)
	{
		key+=kArray[m];
	}
	return key;
}


}
