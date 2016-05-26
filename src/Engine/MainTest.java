package Engine; /**
 * Created by Or Keren on 02/05/2016.
 */
import Engine.DBComm;
import Engine.MeterCommunication;
import Engine.User;


public class MainTest {

    public static final int METER_INTERVAL = 5;

    public static User currentUser;

    public static MeterCommunication communicator;

    public static void main(String[] args) {
        //LoginScreen ls = new LoginScreen();
        communicator = new MeterCommunication();
        new Thread(communicator).start();
        DBComm.init();
        //TODO: Have to make sure that somewhere after the communicator we read all the values


    }
}

