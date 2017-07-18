/* This Class Contains 08 Functions:
	 * XOR function
	 * Shuffle Function
	 * file/DIR check function
	 * Percentage function
	 * openfile function
	 * delencf function
	 * shiftkey function
	 * rounds function
	 */
	import java.io.File;
	import java.io.IOException;
	import java.io.RandomAccessFile;
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
	System.out.println("Enter Mode:\n1.FAST(2 Round Enc/Dec)\t\t2.FASTER(4-R E/D)\t\t3.STANDARD(8-R E/D)\n4.STANDARD-Plus(12-R E/D)\t\t5.EXPRESS(16-R E/D)\n\tMore the rounds,Slower the Process!\n\tUse Same Mode for Enc. and Dec. of the same File.");
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



}
