import javax.ws.rs.*;

// The Java class will be hosted at the URI path "/helloworld"
@Path("/")
public class HelloWorld {
    // The Java method will process HTTP GET requests
    @GET
    @Path("/hello")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String getHello() {
        // Return some cliched textual content
        return "Hello World";
    }

    // The Java method will process HTTP GET requests
    @GET
    @Path("/hello/api")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String getGeneric() {
        return "Getting...";
    }

    // The Java method will process HTTP PUT requests
    @PUT
    @Path("/hello/api/{id}")
    // The Java method will produce content identified by the MIME Media type "text/plain" with the given integer
    @Consumes("text/plain")
    @Produces("text/plain")
    public String putGeneric(@PathParam("id") int id) {
        return "Putting: " + id;
    }

    // The Java method will process HTTP POST requests
    @POST
    @Path("/hello/api/{str}")
    // The Java method will produce content identified by the MIME Media type "text/plain" with the given integer
    @Produces("text/plain")
    public String postGeneric(@PathParam("str") String str) {
        return "Posting: " + str;
    }

    // The Java method will process HTTP DELETE requests
    @DELETE
    @Path("/{id}")
    // The Java method will produce content identified by the MIME Media type "text/plain" with the given integer
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deleteGeneric(@PathParam("id") int id) {
        return "Deleting: " + id;
    }

}