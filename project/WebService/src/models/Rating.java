package models;

import javax.persistence.*;

/**
 * Created by Nate Bender` on 5/12/2017.
 */
@Entity
public class Rating {
    private Long score;
    private String ratingtype;
    private String source;
    @Id
    private String beerId;

    @Basic
    @Column(name = "BEERID")
    public String getBeer(){
        return beerId;
    }
    public void setBeer(String id) {
        beerId = id;
    }

    @Basic
    @Column(name = "SCORE")
    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    @Basic
    @Column(name = "RATINGTYPE")
    public String getRatingtype() {
        return ratingtype;
    }

    public void setRatingtype(String ratingtype) {
        this.ratingtype = ratingtype;
    }

    @Id
    @Column(name = "SOURCE")
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Rating rating = (Rating) o;

        if (score != null ? !score.equals(rating.score) : rating.score != null) return false;
        if (ratingtype != null ? !ratingtype.equals(rating.ratingtype) : rating.ratingtype != null) return false;
        if (source != null ? !source.equals(rating.source) : rating.source != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = score != null ? score.hashCode() : 0;
        result = 31 * result + (ratingtype != null ? ratingtype.hashCode() : 0);
        result = 31 * result + (source != null ? source.hashCode() : 0);
        return result;
    }
}
