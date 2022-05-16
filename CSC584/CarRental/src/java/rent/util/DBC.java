/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rent.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author User
 */
public class DBC 
{
    public static Connection createConnection()
    {
        Connection con=null;
        String url="jdbc:derby://localhost:1527/transport";
        String username="car";
        String password="car";

        try
        {
            try
            {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
            }
            catch(ClassNotFoundException e) 
            {
                //e.printStackTrace();
            }
            con=DriverManager.getConnection(url,username,password);
            //System.out.println("Printing connection object "+con);
        }
        catch(Exception e)
        {
            //e.printStackTrace();
        }
        return con;
    }
}
