import java.util.Date;

/**
 * Created by Or Keren on 02/05/2016.
 */
public class PowerMeter {

    private long m_id;
    private Date m_startDate;
    private Date m_lastReadDate;
    private int m_maxWattage;
    private Customer m_currCustomer;

    private int m_currMonthlyReading;
    private long m_totalReading;



    public PowerMeter(int id, Date startDate) {
        m_id = id;
        m_startDate = startDate;
        m_currCustomer = null;
    }

    public PowerMeter(int id, Date startDate, Customer customer) {
        m_id = id;
        m_startDate = startDate;
        m_currCustomer = customer;
    }


    public Date getLastReadDate() {
        return m_lastReadDate;
    }

    public void setLastReadDate(Date m_lastReadDate) {
        this.m_lastReadDate = m_lastReadDate;
    }

    public int getCurrentMonthlyReading() {
        return m_currMonthlyReading;
    }

    public long getTotalReading(){
        return m_totalReading;
    }

    public Date getStartOperationDate() {
        return m_startDate;
    }

    public long getID() {
        return m_id;
    }

    public int getMaxWattage() {
        return m_maxWattage;
    }

    public void setMaxWattage(int m_maxWattage) {
        this.m_maxWattage = m_maxWattage;
    }

    public Address getCurrentLocation(){
        return m_currCustomer.getAddress();
    }

    public void resetMaxWattage(){
        setMaxWattage(0);
    }


}
