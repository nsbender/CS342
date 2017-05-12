package models;

import javax.persistence.*;

/**
 * Created by Nate Bender` on 5/12/2017.
 */
@Entity
public class Brewery {
    private long id;
    private String name;
    private Long yearfounded;
    private String country;
    private String city;
    private String website;
    private long parentId;

    @ManyToOne
    @JoinColumn(name = "ParentId", referencedColumnName = "id")
    private Parentcompany parentcompany;

    public Parentcompany getParentCompany() {return parentcompany;}

    public void setParentcompany(Parentcompany p) {this.parentcompany = p;}

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "PARENTID")
    public long getParentId() {return this.parentId;}

    public void setParentId(long id) {this.parentId = id;}

    @Basic
    @Column(name = "YEARFOUNDED")
    public Long getYearfounded() {
        return yearfounded;
    }

    public void setYearfounded(Long yearfounded) {
        this.yearfounded = yearfounded;
    }

    @Basic
    @Column(name = "COUNTRY")
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Basic
    @Column(name = "CITY")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Basic
    @Column(name = "WEBSITE")
    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Brewery brewery = (Brewery) o;

        if (id != brewery.id) return false;
        if (name != null ? !name.equals(brewery.name) : brewery.name != null) return false;
        if (yearfounded != null ? !yearfounded.equals(brewery.yearfounded) : brewery.yearfounded != null) return false;
        if (country != null ? !country.equals(brewery.country) : brewery.country != null) return false;
        if (city != null ? !city.equals(brewery.city) : brewery.city != null) return false;
        if (website != null ? !website.equals(brewery.website) : brewery.website != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (yearfounded != null ? yearfounded.hashCode() : 0);
        result = 31 * result + (country != null ? country.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (website != null ? website.hashCode() : 0);
        return result;
    }
}
