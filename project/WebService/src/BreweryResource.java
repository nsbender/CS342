import models.Brewery;
import models.Parentcompany;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the beerdb.
 * It uses a container-managed entity manager.
 *
 */
@Stateless
@Path("beerdb")
public class BreweryResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET an individual Brewery record.
     *
     * @param id the ID of the Beer to retrieve
     * @return a Brewery record
     */
    @GET
    @Path("brewery/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Brewery getBeerEntity(@PathParam("id") long id) {
        return em.find(Brewery.class, id);
    }

    /**
     * GET all Breweries using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all Brewery records
     */
    @GET
    @Path("breweries")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Brewery> getBreweries() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Brewery.class)).getResultList();
    }

    /**
     * PUT new data into an existing Brewery object
     * @param  id of the beer being changed
     * @param  data of the beer to be updated
     * @return a JSON object containing the updated Brewery object
     */
    @PUT
    @Path("brewery/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePerson(Brewery updatedBrewery, @PathParam("id") long id){
        Brewery originalBrewery = em.find(Brewery.class, id);

        // Get the values from the passed in JSON object and apply them  to the person with the same id
        originalBrewery.setName(updatedBrewery.getName());
        originalBrewery.setCity(updatedBrewery.getCity());
        originalBrewery.setCountry(updatedBrewery.getCountry());
        originalBrewery.setWebsite(updatedBrewery.getWebsite());
        originalBrewery.setYearfounded(updatedBrewery.getYearfounded());
        originalBrewery.setId(updatedBrewery.getId());

        Parentcompany originalParentCompany = originalBrewery.getParentCompany();
        Parentcompany updatedParentCompany = updatedBrewery.getParentCompany();

        //If the parent company ID that was passed in doesn't exist, return an error.
        if (em.find(Parentcompany.class, updatedBrewery.getParentCompany()) != null){
            //If the new household id that was passed in exists, just move the brewery to that parent
            if (originalParentCompany.getId() != updatedParentCompany.getId()){
                originalBrewery.setParentcompany(em.find(Parentcompany.class,updatedParentCompany.getId()));
            }
            //If the household hasnt changed, keep the household number the same
            else {
                originalBrewery.setParentcompany(updatedBrewery.getParentCompany());
            }
        }
        else {
            return Response.serverError().entity("No such parent company!").build();
        }

        // If this all works fine, send an OK response with the updated object as proof
        return Response.ok(em.find(Brewery.class,id),MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST new Brewery data into a new Brewery object
     * @param  JSON data of the brewery to be added
     * @return a JSON object containing the new Brewery object
     */
    @POST
    @Path("brewery")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postPerson(Brewery newBrewery){
        //Create a new beer object for values to be passed into
        Brewery theBrewery = new Brewery();

        theBrewery.setName(newBrewery.getName());
        theBrewery.setParentcompany(newBrewery.getParentCompany());
        theBrewery.setYearfounded(newBrewery.getYearfounded());
        theBrewery.setWebsite(newBrewery.getWebsite());
        theBrewery.setCountry(newBrewery.getCountry());
        theBrewery.setCity(newBrewery.getCity());
        theBrewery.setParentId(newBrewery.getParentId());

        em.persist(theBrewery);
        // return the new beer object upon completion
        return Response.ok(theBrewery,MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE the Brewery with the specified ID
     * @param  id of the Brewery to be deleted
     * @return a success code
     */
    @DELETE
    @Path("brewery/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deleteBrewery( @PathParam("id") long id){
        //Check that the id is a valid id
        if (em.find(Brewery.class,id) == null){
            return "The specified brewery does not exist";
        }
        else {
            em.remove(em.find(Brewery.class,id));
            return "Brewery removed successfully.";
        }
    }

    /**
     * POST new Parent Company data into a new Parent Company object
     * @param  JSON data of the Parent Company to be added
     * @return a JSON object containing the new Parent Company object
     */
    @POST
    @Path("parentcompany")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postPerson(Parentcompany newParentCompany){
        //Create a new beer object for values to be passed into
        Parentcompany theParentCompany = new Parentcompany();

        theParentCompany.setName(newParentCompany.getName());
        theParentCompany.setCountry(newParentCompany.getCountry());

        em.persist(theParentCompany);
        // return the new beer object upon completion
        return Response.ok(theParentCompany,MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE the Parent Company with the specified ID
     * @param  id of the Parent Company to be deleted
     * @return a success code
     */
    @DELETE
    @Path("parentcompany/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deleteParentCompany( @PathParam("id") long id){
        //Check that the id is a valid id
        if (em.find(Parentcompany.class,id) == null){
            return "The specified parent company does not exist";
        }
        else {
            em.remove(em.find(Parentcompany.class,id));
            return "Parent company removed successfully.";
        }
    }

}