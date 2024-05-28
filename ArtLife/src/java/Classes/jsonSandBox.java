/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.util.List;
import java.util.Random;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author Chamal
 */
public class jsonSandBox {

    public static void main(String[] args) {

        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

        JSONParser jbagParser = new JSONParser();
        JSONObject jSONObject = new JSONObject();

        double total = 0.00;

        JSONArray array = new JSONArray();

        Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
        bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, 14)),
                Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

        List<Pojos.ShopBag> bagList = bagCriteria.list();

        for (Pojos.ShopBag bagItem : bagList) {

            try {
                Object jObject = jbagParser.parse(bagItem.getMeta());
                JSONObject metaObj = (JSONObject) jObject;

                JSONObject childObject = new JSONObject();

                childObject.put("id", bagItem.getProducts().getId());
                childObject.put("qty", bagItem.getQuantity());
                childObject.put("unitprice", metaObj.get("sellingPrice").toString());
                childObject.put("tot", Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString()));

                total = total + Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString());

                array.add(childObject);
            } catch (Exception e) {
            }

        }
        JSONObject pm = new JSONObject();
        pm.put("num", "12123123123");
        pm.put("exp", "12");

        jSONObject.put("products", array);
        jSONObject.put("payment", pm);

        System.out.println(jSONObject.toString());
        System.out.println(array.size());
        System.out.println(total);

    }
}
