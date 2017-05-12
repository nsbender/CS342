import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

@ApplicationPath("/") // Base URI
public class ServerApplication extends Application{

	// Define each of the classes that we want the application to serve
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( BeerResource.class );
        h.add( BreweryResource.class );
        h.add( DistributorResource.class );
        return h;
    }
}