import models.Household;
import models.Person;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.ResourceBundle;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

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
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Person getPerson(@PathParam("id") long id) {
        return em.find(Person.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Person.class)).getResultList();
    }

    /**
     * PUT new data into an existing Person object
     * @param  id of the person being changed
     * @param  data of the person to be updated
     * @return a JSON object containing the updated Person object
     */
    @PUT
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePerson(Person updatedPerson, @PathParam("id") long id){
        Person originalPerson = em.find(Person.class, id);

        // Get the values from the passed in JSON object and apply them  to the person with the same id
        originalPerson.setTitle(updatedPerson.getTitle());
        originalPerson.setFirstname(updatedPerson.getFirstname());
        originalPerson.setLastname(updatedPerson.getLastname());
        originalPerson.setMembershipstatus(updatedPerson.getMembershipstatus());
        originalPerson.setGender(updatedPerson.getGender());
        originalPerson.setBirthdate(updatedPerson.getBirthdate());
        originalPerson.setHousehold(updatedPerson.getHousehold());
        originalPerson.setHouseholdrole(updatedPerson.getHouseholdrole());

        // Now we need to update the Household table to match what is in the Person record
        Household originalHousehold = originalPerson.getHousehold(); // Returns the entire household that this person belongs to
        Household updatedHousehold = updatedPerson.getHousehold();

        //If the household ID that was passed in doesn't exist, return an error.
        if (em.find(Household.class, updatedHousehold.getId()) != null){
            //If the new household id that was passed in exists, just move the person to that household
            if (originalHousehold.getId() != updatedHousehold.getId()){
                originalPerson.setHousehold(em.find(Household.class,updatedHousehold.getId()));
            }
            //If the household hasnt changed, keep the household number the same
            else {
                originalPerson.setHousehold(updatedPerson.getHousehold());
            }
        }
        else {
            return Response.serverError().entity("No such household!").build();
        }

        // If this all works fine, send an OK response with the updated object as proof
        return Response.ok(em.find(Person.class,id),MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST new Person data into a new Person object
     * @param  JSON data of the person to be added
     * @return a JSON object containing the new Person object
     */
    @POST
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postPerson(Person newPerson){
        //Create a new person object for values to be passed into
        Person thePerson = new Person();

        thePerson.setTitle(newPerson.getTitle());
        thePerson.setFirstname(newPerson.getFirstname());
        thePerson.setLastname(newPerson.getLastname());
        thePerson.setMembershipstatus(newPerson.getMembershipstatus());
        thePerson.setGender(newPerson.getGender());
        thePerson.setBirthdate(newPerson.getBirthdate());
        thePerson.setHousehold(newPerson.getHousehold());
        thePerson.setHouseholdrole(newPerson.getHouseholdrole());

        // Take the passed in Id and set the household accordingly
        long id = newPerson.getId();
        Household newHousehold = em.find(Household.class, id);
        thePerson.setHousehold(newHousehold);

        em.persist(thePerson);
        // return the new person object upon completion
        return Response.ok(thePerson,MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE the Person with the specified ID
     * @param  id of the Person to be deleted
     * @return a success code
     */
    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deletePerson( @PathParam("id") long id){
        //Check that the id is a valid id
        if (em.find(Person.class,id) == null){
            return "The specified person does not exist";
        }
        else {
            em.remove(em.find(Person.class,id));
            return "Person removed successfully.";
        }
    }

}