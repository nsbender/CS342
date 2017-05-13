import models.Beer;
import models.Distributor;
import models.Distributorbeer;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the Distributor and DistributorBeer objects of the beerdb.
 * It uses a container-managed entity manager.
 */
@Stateless
@Path("beerdb")
public class DistributorResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET an individual Distributor record.
     *
     * @param id the ID of the Distributor to retrieve
     * @return a Distributor record
     */
    @GET
    @Path("distributor/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Distributor getBeerEntity(@PathParam("id") long id) {
        return em.find(Distributor.class, id);
    }

    /**
     * GET a list of all distributors of a particular beer
     *
     * @param id the ID of the Beer whose distributors to retrieve
     * @return a list of distributors
     */
    @GET
    @Path("distributor/beer/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Distributor> getBeerDistributors(@PathParam("id") long id) {
        //Query the distributor table for all distributors who distribute the specified beer
        return em.createQuery("SELECT * FROM DistributorBeer WHERE beerId = " + id).getResultList();
    }

    /**
     * POST new Distributor data into a new Distributor object
     * @param  JSON data of the rating to be added
     * @return a JSON object containing the new rating object
     */
    @POST
    @Path("distributor")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postRating (Distributor newDistributor){
        //Create a new Distributor object for values to be passed into
        Distributor theDistributor = new Distributor();

        theDistributor.setAddress(newDistributor.getAddress());
        theDistributor.setName(newDistributor.getName());

        em.persist(theDistributor);
        // return the new beer object upon completion
        return Response.ok(theDistributor,MediaType.APPLICATION_JSON).build();
    }

    /**
     * GET all Distributors using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all distributor records
     */
    @GET
    @Path("distributors")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Distributor> getDistributors() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Distributor.class)).getResultList();
    }

    /**
     * PUT new data into an existing Distributor object
     * @param  id of the Distributor being changed
     * @param  data of the Distributor to be updated
     * @return a JSON object containing the updated Distributor object
     */
    @PUT
    @Path("distributor/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePerson(Distributor updatedDistributor, @PathParam("id") long id){
        Distributor originalDistributor = em.find(Distributor.class, id);

        // Get the values from the passed in JSON object and apply them  to the person with the same id
        originalDistributor.setName(updatedDistributor.getName());
        originalDistributor.setAddress(updatedDistributor.getAddress());

        // If this all works fine, send an OK response with the updated object as proof
        return Response.ok(em.find(Distributor.class,id),MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE the Distributor with the specified ID
     * @param  id of the Distributor to be deleted
     * @return a success code
     */
    @DELETE
    @Path("distributor/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deleteDistributor( @PathParam("id") long id){
        //Check that the id is a valid id
        if (em.find(Distributor.class,id) == null){
            return "The specified distributor does not exist";
        }
        else {
            em.remove(em.find(Beer.class,id));
            return "Distributor removed successfully.";
        }
    }



}