/* This Class Contains 11 Functions:
	 * XOR function
	 * Shuffle Function
	 * file/DIR check function
	 * Percentage function
	 * openfile function
	 * delencf function
	 * shiftkey function
	 * rounds function
	 * EstimateTime function
	 * CopyFile function
	 * KeyGen function
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
		
	public static void xor(RandomAccessFile in,RandomAccessFile temp,String key,String mode,String round)
		{

		int len_var=0;
			try
			{
				long incount=in.length();int p=0;double percent;
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
					percent=percentage(p,incount);
					p++;
					System.out.println("["+round+"]"+" "+mode+" Characters to File:"+percent + "%"); 	
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




	public static int check(String filename)
	{	
		int flag=0;	 
	    File filechk = new File(filename);
	        if(filechk.isFile())
	        	flag=1;
			else if(filechk.isDirectory())
			    flag=2;
		if(flag!=1&&flag!=2)
			System.out.println("'"+filename+"'"+" is not a Valid FILE/DIRECTORY!");
	 return flag;
		
	}

	public static double percentage(long no, long total)			//percent function
	{
		double per = (no*100.0)/total; 
		per = per * 100;		
	    per = Math.round(per);	
	    per = per/100;			
	    return per;
	}

	
	
	public static void openfile(String filename)
	{
		try {
			RandomAccessFile in=new RandomAccessFile(filename,"r");
			int check=0;
			while(check==0)
			{	
				String str=in.readLine();
				if(str==null)
					{	check=1;
						break;
					}
				else
					System.out.println(str);
				
			}
			in.close();
		} catch (IOException e) {
			System.out.println(e);
				}
		
	}
	
	

public static void delencf(String filename, int ch)
{
	if(ch==1)
	{
	File f = new File(filename);	
	 if(f.delete())
		 System.out.println(filename+" deleted Successfully!");
	 else 
		 System.out.println("\nCouldn't Locate "+filename+" to delete!");
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

public static void rounds(RandomAccessFile in,RandomAccessFile out,String key,int shiftby,String mode)		//round Encryption/decryption
{
	FunctionSet obj=new FunctionSet();
	
	int round=0,ch=0;
	String roundname="";
	System.out.println("=========================================================================");
	System.out.println("Enter Mode:\n1.FAST(2 Round Enc/Dec)\t\t--Estimated Time :: "+EstTime(in,2)+" seconds ("+(EstTime(in,2))/60+" minutes)\n2.FASTER(4-R E/D)\t\t--Estimated Time :: "+EstTime(in,4)+" seconds ("+(EstTime(in,4))/60+" minutes)\n3.STANDARD(8-R E/D)\t\t--Estimated Time :: "+EstTime(in,8)+" seconds ("+(EstTime(in,8))/60+" minutes)\n4.STANDARD-Plus(12-R E/D)\t--Estimated Time :: "+EstTime(in,12)+" seconds ("+(EstTime(in,12))/60+" minutes)\n5.EXPRESS(16-R E/D)\t\t--Estimated Time :: "+EstTime(in,16)+" seconds ("+(EstTime(in,16))/60+" minutes)\n\t\tUse Same Mode for Decryption with which the File was ENcrypted!");
	System.out.println("=========================================================================");
	if(obj.inscan.hasNextInt())
		ch=obj.inscan.nextInt();
	
		if(ch==1){
			round=2;
			roundname="2 Round Enc/Dec";
			}
		else if(ch==2){
			round=4;
			roundname="4 Round Enc/Dec";
			}
		else if(ch==3){
			round=8;
			roundname="8 Round Enc/Dec";
			}
		else if(ch==4)
			{round=12;
			roundname="12 Round Enc/Dec";
			}
		else if(ch==5){
			round=16;
			roundname="16 Round Enc/Dec";
			}
		else
			System.out.println("Invalid Option!");

		if(key.length()%2!=0)
			round--;

		for(int i=1;i<=round;i++)		//Apply Alternate rounds
			{
			
				if(i%2!=0)
				{
					System.out.println("\t\t\tROUND--"+i);
					key=FunctionSet.shiftKey(key,shiftby);
					FunctionSet.xor(in, out, key,mode,"Round-"+i);		
				}
				else
				{
					System.out.println("\t\t\tROUND--"+i);
					key=FunctionSet.shiftKey(key,shiftby);
					FunctionSet.xor(out, in, key,mode,"Round-"+i);
				}	
			}
		System.out.println("\t\t\t"+roundname+ " Successfully Completed!");

}

public static double EstTime(RandomAccessFile inputfn, int rounds)
{
	
	
		//File input=new File(inputfn);
		double bytes=0;
		try {
			bytes = inputfn.length();
		} catch (IOException e) {
			System.out.println(e);
		}
		double kb=bytes/1024;
		
		kb=kb*100000;	
		kb=Math.round(kb);
		kb=kb/100000;				//file size in kb with 5 decimal places only
		double ests=(kb/58.5)*rounds;		//estimated seconds-->ANALYSIS=58.5kb take 1 sec
		ests=ests*100000;		
		ests=Math.round(ests);		
		ests=ests/100000;
		
		/*		double estm=ests/60;		//estimated minutes
		estm=estm*10000;		
		estm=Math.round(estm);		
		estm=estm/10000;			//estminutes with only upto 5 decimal places
	*/	
	return ests;
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
		System.out.println("Generating 200 byte key from Entered key: "+FunctionSet.percentage(m, key.length()-1)+"%");
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
System.out.println(key.length()+" Byte Key Generated Successfully!");
	return key;
}


}
