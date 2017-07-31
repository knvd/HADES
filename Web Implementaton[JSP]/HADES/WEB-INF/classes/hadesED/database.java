package hadesED;

/* THIS CLASS CONTAINS ESSENTIAL FUNCTIONS VIZ CONNECT TO DATABASE ,INSERT TO TABLE,
 *  SELECT DATA SET FROM TABLE, COUNT THE NO. OF RESULTS RETURNED BY A QUERY..THESE
 *  FUNCTIONS ARE ALWAYS USED REDUNDANTLY SO I HAVE MADE A SEPERATE CLASS OF THEM.
 *   THE FUNCTIONS OF THIS CLASS SERVE TO THE CLASS registration.java.
 */

import java.sql.*;
public class database {
	
	Connection cn;
	Statement st;
	ResultSet rs;
	
	public boolean connect(String ip,String db,String usr,String pswd)	//Function to connect to database
	{
		boolean connect=false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String dbcon = "jdbc:mysql://"+ip+":3306/"+db;
			cn=DriverManager.getConnection(dbcon,usr,pswd);
			connect=true;
			}
		catch (ClassNotFoundException | SQLException e) 
			{
				//e.printStackTrace();
			}
		return connect;	
		
	}
	
	public boolean insert(String qry)		//Function to Insert into table
	{
		boolean insert=false;
		try {
			st=cn.createStatement();
			st.executeUpdate(qry);
			insert=true;
			} 
		catch (SQLException e) 
			{
				e.printStackTrace();
			}
			return insert;
	}
	
	public ResultSet select(String qry)		//function to Get result from database
	{
		try {
			st=cn.createStatement();
			rs=st.executeQuery(qry);
			
			} 
		catch (SQLException e) 
			{
				e.printStackTrace();
			}
		return rs;
	}
	
	public int count(String qry)		//function to get the no of rows returned for a query
	{
		int flag=0;
		try 
		{
			st=cn.createStatement();
			rs=st.executeQuery(qry);
			rs.last();
			flag=rs.getRow();

		} catch (SQLException e) 
		{
			e.printStackTrace();
		}
				return flag;
	}


	
}