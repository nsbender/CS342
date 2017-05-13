package models;

import javax.persistence.*;
import java.sql.Time;
import java.util.List;

/**
 * Created by Nate Bender` on 5/12/2017.
 */
@Entity
public class Beer {
    @Id
    private long id;
    private String name;
    private String variety;
    private Long ibu;
    private String inproduction;
    private Time introduced;
    private Long abv;

    @ManyToOne
    @JoinColumn(name = "BreweryId", referencedColumnName = "id")
    private Brewery brewery;

    @OneToMany
    @JoinTable(name = "Rating", schema = "beerdb",
        joinColumns = @JoinColumn(name = "beerId", referencedColumnName = "id", nullable = false))
    private List<Rating> ratings;

    @ManyToMany
    @JoinTable(name = "Beeringredient", schema = "beerdb",
        joinColumns = @JoinColumn(name = "beerId", referencedColumnName = "id", nullable = false))
    private List<Ingredient> ingredients;

    public Brewery getBrewery(){
        return brewery;
    }

    public List<Rating> getRatings(){
        return ratings;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setBrewery( Brewery b) {this.brewery = b;}

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
    @Column(name = "VARIETY")
    public String getVariety() {
        return variety;
    }

    public void setVariety(String variety) {
        this.variety = variety;
    }

    @Basic
    @Column(name = "IBU")
    public Long getIbu() {
        return ibu;
    }

    public void setIbu(Long ibu) {
        this.ibu = ibu;
    }

    @Basic
    @Column(name = "INPRODUCTION")
    public String getInproduction() {
        return inproduction;
    }

    public void setInproduction(String inproduction) {
        this.inproduction = inproduction;
    }

    @Basic
    @Column(name = "INTRODUCED")
    public Time getIntroduced() {
        return introduced;
    }

    public void setIntroduced(Time introduced) {
        this.introduced = introduced;
    }

    @Basic
    @Column(name = "ABV")
    public Long getAbv() {
        return abv;
    }

    public void setAbv(Long abv) {
        this.abv = abv;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Beer beer = (Beer) o;

        if (id != beer.id) return false;
        if (name != null ? !name.equals(beer.name) : beer.name != null) return false;
        if (variety != null ? !variety.equals(beer.variety) : beer.variety != null) return false;
        if (ibu != null ? !ibu.equals(beer.ibu) : beer.ibu != null) return false;
        if (inproduction != null ? !inproduction.equals(beer.inproduction) : beer.inproduction != null) return false;
        if (introduced != null ? !introduced.equals(beer.introduced) : beer.introduced != null) return false;
        if (abv != null ? !abv.equals(beer.abv) : beer.abv != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (variety != null ? variety.hashCode() : 0);
        result = 31 * result + (ibu != null ? ibu.hashCode() : 0);
        result = 31 * result + (inproduction != null ? inproduction.hashCode() : 0);
        result = 31 * result + (introduced != null ? introduced.hashCode() : 0);
        result = 31 * result + (abv != null ? abv.hashCode() : 0);
        return result;
    }
}
