package Engine; /**
 * Created by Or Keren on 02/05/2016.
 */
import Engine.DBComm;
import Engine.MeterCommunication;
import Engine.User;

import java.util.Date;


public class MainTest {

    public static final int METER_INTERVAL = 5;

    public static User currentUser;

    public static MeterCommunication communicator;

    public static void main(String[] args) {
        //LoginScreen ls = new LoginScreen();
        //communicator = new MeterCommunication();
        currentUser =new Customer();
      //  new Thread(communicator).start();
       // DBComm.init();
//        PowerMeter m = new PowerMeter(0, new Date());
//        DBComm.deletePowerMeter(m);
//        m.readWattage();
//        DBComm.addNewMeter(m);;
//        DBComm.getMeterById(23);
        Address d=new Address("234","234","234","234",2);
        Customer n= new Customer("sfd","@43",234,d);
        DBComm.getAllMeterdByUserId(1);
       DBComm.insertDataBill(5,5,new Date(),true);

        //TODO: Have to make sure that somewhere after the communicator we read all the values


    }
}


