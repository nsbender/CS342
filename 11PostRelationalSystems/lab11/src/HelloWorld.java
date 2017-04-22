// Nate Bender, HelloWorld.java

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;


@Path("/hello") // The URL that the page can be accessed at
public class HelloWorld {
    @GET
    @Produces("text/plain") // Page and content type
    public String getClichedMessage() {
        return "Hello World";
    }
}