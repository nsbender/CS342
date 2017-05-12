import models.Beer;
import models.Brewery;
import models.Rating;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the Beer and Rating objects of the beerdb.
 * It uses a container-managed entity manager.
 */
@Stateless
@Path("beerdb")
public class BeerResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual Beer record.
     *
     * @param id the ID of the Beer to retrieve
     * @return a Beer record
     */
    @GET
    @Path("beer/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Beer getBeerEntity(@PathParam("id") long id) {
        return em.find(Beer.class, id);
    }

    /**
     * GET a list of all ratings for a beer
     *
     * @param id the ID of the Beer whose ratings to retrieve
     * @return a list of ratings
     */
    @GET
    @Path("beer/{id}/ratings")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Rating> getRatings(@PathParam("id") long id) {
        //Query the rating table for all ratings where the beer equals the passed in id
        return em.createQuery("SELECT * FROM Rating WHERE beerId = " + id + ";").getResultList();
    }

    /**
     * POST new Rating data into a new Rating object
     * @param  JSON data of the rating to be added
     * @return a JSON object containing the new rating object
     */
    @POST
    @Path("rating")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postRating (Rating newRating){
        //Create a new rating object for values to be passed into
        Rating theRating = new Rating();

        theRating.setBeer(newRating.getBeer());
        theRating.setRatingtype(newRating.getRatingtype());
        theRating.setScore(newRating.getScore());
        theRating.setSource(newRating.getSource());

        em.persist(theRating);
        // return the new beer object upon completion
        return Response.ok(theRating,MediaType.APPLICATION_JSON).build();
    }

    /**
     * GET all Beers using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all Beer records
     */
    @GET
    @Path("beers")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Beer> getBeers() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Beer.class)).getResultList();
    }

    /**
     * GET all beers with a particular ingredient
     *
     * @param name the name of the Ingredient to search for in Beers
     * @return a list of Beer Ids
     */
    @GET
    @Path("beer/ingredient/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Long> getBeersWithIngredient(@PathParam("name") String ingredient) {
        return em.createQuery("select b.id from Beer b, Ingredient i, Beeringredient bi where i.name = 'Citra' AND bi.IngredientId = i.id AND b.id = bi.beerId;").getResultList();
    }

    /**
     * PUT new data into an existing Beer object
     * @param  id of the beer being changed
     * @param  data of the beer to be updated
     * @return a JSON object containing the updated Beer object
     */
    @PUT
    @Path("beer/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePerson(Beer updatedBeer, @PathParam("id") long id){
        Beer originalBeer = em.find(Beer.class, id);

        // Get the values from the passed in JSON object and apply them  to the person with the same id
        originalBeer.setName(updatedBeer.getName());
        originalBeer.setAbv(updatedBeer.getAbv());
        originalBeer.setIbu(updatedBeer.getIbu());
        originalBeer.setInproduction(updatedBeer.getInproduction());
        originalBeer.setIntroduced(updatedBeer.getIntroduced());
        originalBeer.setVariety(updatedBeer.getVariety());
        originalBeer.setBrewery(updatedBeer.getBrewery());

        Brewery originalBrewery = originalBeer.getBrewery();
        Brewery updatedBrewery = updatedBeer.getBrewery();

        //If the brewery ID that was passed in doesn't exist, return an error.
        if (em.find(Brewery.class, updatedBeer.getId()) != null){
            //If the new household id that was passed in exists, just move the person to that household
            if (originalBrewery.getId() != updatedBrewery.getId()){
                originalBeer.setBrewery(em.find(Brewery.class,updatedBrewery.getId()));
            }
            //If the household hasnt changed, keep the household number the same
            else {
                originalBeer.setBrewery(updatedBeer.getBrewery());
            }
        }
        else {
            return Response.serverError().entity("No such brewery!").build();
        }

        // If this all works fine, send an OK response with the updated object as proof
        return Response.ok(em.find(Beer.class,id),MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST new Beer data into a new Beer object
     * @param  JSON data of the beer to be added
     * @return a JSON object containing the new Beer object
     */
    @POST
    @Path("beer")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postPerson(Beer newBeer){
        //Create a new beer object for values to be passed into
        Beer theBeer = new Beer();

        theBeer.setName(newBeer.getName());
        theBeer.setBrewery(newBeer.getBrewery());
        theBeer.setVariety(newBeer.getVariety());
        theBeer.setIntroduced(newBeer.getIntroduced());
        theBeer.setInproduction(newBeer.getInproduction());
        theBeer.setIbu(newBeer.getIbu());
        theBeer.setAbv(newBeer.getAbv());


        // Take the passed in Id and set the brewery accordingly
        long id = newBeer.getId();
        Brewery newBrewery = em.find(Brewery.class, id);
        theBeer.setBrewery(newBrewery);

        em.persist(theBeer);
        // return the new beer object upon completion
        return Response.ok(theBeer,MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE the Beer with the specified ID
     * @param  id of the Beer to be deleted
     * @return a success code
     */
    @DELETE
    @Path("beer/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deleteBeer( @PathParam("id") long id){
        //Check that the id is a valid id
        if (em.find(Beer.class,id) == null){
            return "The specified beer does not exist";
        }
        else {
            em.remove(em.find(Beer.class,id));
            return "Beer removed successfully.";
        }
    }

}