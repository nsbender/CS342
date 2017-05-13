package models;

import javax.persistence.*;

/**
 * Created by Nate Bender` on 5/12/2017.
 */
@MappedSuperclass
public class Distributorbeer {

    private Long beerId;
    private Long distributorId;
    private Long unitsize;
    private Long cost;

    @Basic
    @Column(name = "UNITSIZE")
    public Long getUnitsize() {
        return unitsize;
    }

    public void setUnitsize(Long unitsize) {
        this.unitsize = unitsize;
    }

    @Basic
    @Column(name = "BEERID")
    public Long getBeerId() {
        return beerId;
    }

    public void setBeerId(Long newId) {
        this.beerId = newId;
    }

    @Basic
    @Column(name = "DISTRIBUTORID")
    public Long getDistributorId() {
        return distributorId;
    }

    public void setDistributorId(Long newId) {
        this.distributorId = newId;
    }

    @Basic
    @Column(name = "COST")
    public Long getCost() {
        return cost;
    }

    public void setCost(Long cost) {
        this.cost = cost;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Distributorbeer that = (Distributorbeer) o;

        if (unitsize != null ? !unitsize.equals(that.unitsize) : that.unitsize != null) return false;
        if (cost != null ? !cost.equals(that.cost) : that.cost != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = unitsize != null ? unitsize.hashCode() : 0;
        result = 31 * result + (cost != null ? cost.hashCode() : 0);
        return result;
    }
}
