package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Asiakas;

public class Dao {
	private Connection con=null;
	private ResultSet rsl = null;
	private PreparedStatement prep=null; 
	private String sql;
	private String db ="Myynti.sqlite";
	
	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");    	
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/"); //Eclipsessa
    	//path += "/webapps/"; //Tuotannossa. Laita tietokanta webapps-kansioon
    	String url = "jdbc:sqlite:"+path+db;    	
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Connection open.");
	     }catch (Exception e){	
	    	 System.out.println("Connection failed.");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	
	public ArrayList<Asiakas> listAll() {
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>(); 
		sql = "SELECT * FROM asiakkaat"; 
		try {
			con=yhdista();
			if (con!=null) {
				prep = con.prepareStatement(sql); 
				rsl = prep.executeQuery(); 
				if (rsl!=null) {
					System.out.println();
					while (rsl.next()) {
						Asiakas nouto= new Asiakas(); 
						nouto.setAsiakas_id(rsl.getInt(1));
						nouto.setEtunimi(rsl.getString(2));
						nouto.setSukunimi(rsl.getString(3));
						nouto.setPuhelin(rsl.getString(4));
						nouto.setSposti(rsl.getString(5));
						asiakkaat.add(nouto); 
					}
				}
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	public ArrayList<Asiakas> listAll(String seek) {
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>(); 
		sql = "SELECT * FROM asiakkaat WHERE etunimi LIKE ? or sukunimi LIKE ? or puhelin LIKE ? or sposti LIKE ?"; 
		try {
			con=yhdista();
			if (con!=null) {
				prep = con.prepareStatement(sql);
				prep.setString(1, "%" + seek + "%");
				prep.setString(2, "%" + seek + "%");
				prep.setString(3, "%" + seek + "%");
				prep.setString(4, "%" + seek + "%");
				rsl = prep.executeQuery(); 
				if (rsl!=null) {
					System.out.println();
					while (rsl.next()) {
						Asiakas nouto= new Asiakas(); 
						nouto.setAsiakas_id(rsl.getInt(1));
						nouto.setEtunimi(rsl.getString(2));
						nouto.setSukunimi(rsl.getString(3));
						nouto.setPuhelin(rsl.getString(4));
						nouto.setSposti(rsl.getString(5));
						asiakkaat.add(nouto); 
					}
				}
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	public boolean addCustomer(Asiakas asiakas) {
		boolean paluu = true; 
		sql = "INSERT INTO asiakkaat (etunimi, sukunimi, puhelin, sposti) VALUES (?,?,?,?)";
		try {
			con=yhdista();
			prep = con.prepareStatement(sql); 
			prep.setString(1, asiakas.getEtunimi());
			prep.setString(2, asiakas.getSukunimi());
			prep.setString(3, asiakas.getPuhelin());
			prep.setString(4, asiakas.getSposti());
			prep.executeUpdate(); 
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluu=false; 
		}
		return paluu; 
	}
	
	public boolean poistaAsiakas(String asiakas_id) {
		boolean paluu = true;
		//asiakas_id = Integer.parseInt(asiakas_id);
		sql = "DELETE FROM asiakkaat WHERE asiakas_id=?";
		try {
			con=yhdista();
			prep = con.prepareStatement(sql);
			prep.setString(1, asiakas_id);
			prep.executeUpdate(); 
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			paluu=false; 
		}		
		return paluu; 
		
	}
	

}
