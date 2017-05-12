/**
 * Created by nsb2 on 5/11/2017.
 */

import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetMovieActors {
    public static void main(String[] args) throws SQLException {
        KVStore kvstore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadDB(kvstore);

        getValues(kvstore);
        kvstore.close();
    }

    public static void getValues(KVStore kvstore){
        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actors"));
        Map<Key, ValueVersion> fields = kvstore.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) { // for loops on maps are one of the greatest things ever

            // Retrieve the actor and their relevant information, and store it
            String actorid = field.getKey().getMinorPath().get(1);
            Map<Key, ValueVersion> actor = kvstore.multiGet(Key.createKey(Arrays.asList("actor", actorid)), null, null);
            String firstname = "";
            String lastname = "";
            for (Map.Entry<Key, ValueVersion> myfield : actor.entrySet()) {
                firstname = new String(myfield.getValue().getValue().getValue());
                lastname = new String(myfield.getValue().getValue().getValue());
            }

            //Retrieve and print the actors role alongside their name
            String[] roles = new String(field.getValue().getValue().getValue()).split(":, ");
            for (String role : roles) {
                System.out.println(actorid + "\t" + firstname + " " + lastname + "\t" + role);
            }
        }
    }
}
