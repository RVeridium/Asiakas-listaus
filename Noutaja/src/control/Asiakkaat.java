package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import model.Asiakas;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("Asiakkaat.doGet()");
		String pathInfo =request.getPathInfo();
		//System.out.println(pathInfo);
		String sStr="";
		Dao dao = new Dao();
		ArrayList<Asiakas> asLista = new ArrayList<Asiakas>(); 
		if(pathInfo==null) {
			asLista=dao.listAll();
		}
		if(pathInfo!=null) {
			sStr=pathInfo.replace("/","");
			asLista=dao.listAll(sStr);
		}
		//nyt parametritonta gettiä ei käytetä ollenkaan, mikä voi hidastaa jos datasetti on iso. 
		//System.out.println(asLista);
		String asJSON= new JSONObject().put("asiakkaat", asLista).toString(); 
		response.setContentType("application/json");
		PrintWriter out=response.getWriter(); 
		out.println(asJSON); //tulostaa selaimeen. 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("fName"));
		asiakas.setSukunimi(jsonObj.getString("lName"));
		asiakas.setPuhelin(jsonObj.getString("phone"));
		asiakas.setSposti(jsonObj.getString("email"));
		response.setContentType("application/json");
		PrintWriter out=response.getWriter();
		Dao dao = new Dao();
		if (dao.addCustomer(asiakas)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}
		
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, esim. /ABC-222		
		System.out.println("polku: "+pathInfo);
		String poisto_id = pathInfo.replace("/", "");		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.poistaAsiakas(poisto_id)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Auton poistaminen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Auton poistaminen ep�onnistui {"response":0}
		}
		
		
		
		
		
		//korjaa style.css johonkin kuntoo. 
	}

}
