package Aspects;
import Engine.*;

import java.util.LinkedList;
import java.util.List;

/**
 * There are a lot of places in the code which deal with disconnecting/specifically changing the status of a meter
 * to INACTIVE
 * Created by Or Keren on 21/05/2016.
 */
public aspect DisconnectMeterAspect {


    /**
     * This pointcut is when a client has disconnected from the company, we have to delete all his
     * meter's from the DB
     */
    pointcut ClientDisconnected(Customer c) : call(* Engine.DBComm.deleteCustomer(Customer)) && args(c);

    /**
     * This pointcut should happen after calling to the function which returns all the customers
     * Who have not payed their bill
     */
    pointcut ClientBillNotPayed() : call(* Engine.BillingEngine.checkMonthlyBilling());

    /**
     * When a meter reaches his max wattage then we need to deal with it - in this case setting the meter
     * to INACTIVE
     */
    pointcut MeterWattageMaxed() : call(* Engine.PowerMeter.readWattage());

    /**
     * When a region is overloaded, we need to inactivate all meters
     */
    pointcut MeterWattageOverload(): call(* Engine.MeterCommunication.readAllMeters());

    /**
     * This advice should check the wattage returned and if the wattage is over the max wattage, the meter
     * should be Disconnected (i.e set to INACTIVE)
     */
    after() returning(int watt) : MeterWattageMaxed(){
        PowerMeter currMeter =((PowerMeter)thisJoinPoint.getTarget());
        int maxWattage = currMeter.getMaxWattage();
        if(watt >= maxWattage){
            currMeter.setInactive();
            //DBComm.updateMeter(currMeter);
            //TODO: ADD the function which changes the status of the meter to DBComm
        }
    }

    /**
     * This advice occurs before a client is removed from the DB. We need to get all the meters he has
     * and set then as delete them from the DB
     */
    after(Customer c) : ClientDisconnected(c){
        LinkedList<PowerMeter> userMeters = DBComm.getAllMeterdByUserId(c.getID());
        userMeters.forEach(DBComm::deltePowerMeter);
        //TODO: Check if we need to add some more functionality here (maybe calculating bill and stuff)


    }

    /**
     * This advice occurs after all the meters have been read.
     * It goes through each city, and checks if the city's power is overloaded
     * if it is - it sets all the meters to INACTIVE
     */
    after() : MeterWattageOverload(){
        //List<String> cities = DBComm.getCities(); //TODO: Add to DBComm (maybe filter according to country)
        List<String> cities = new LinkedList<>();
        for(String city : cities){
            checkAndHandleOverload(city);
        }
    }



    private void checkAndHandleOverload(String city){
        int cityWattage = 0;
        List<PowerMeter> cityActiveMeters = DBComm.getAllMetersByCity(city);
        for(PowerMeter m : cityActiveMeters){
            cityWattage += m.getCurrentWattage();
        }

        if(cityWattage >= 10000){ //TODO: Constant
            cityActiveMeters.forEach(PowerMeter::setInactive);
        }
    }

    /**
     * This Advicde occurs after a successful return of the function which returns all the customers
     * who have not payed their monthly bill. Their meters need to be set as INACTIVE
     */
    after() returning(List<Customer> customers) : ClientBillNotPayed(){
        for(Customer c: customers){
            List<PowerMeter> clientMeters = DBComm.getAllMeterdByUserId(c.getID());
            clientMeters.forEach(PowerMeter::setInactive);
        }

    }





}
