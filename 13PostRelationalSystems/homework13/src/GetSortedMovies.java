/**
 * Created by nsb2 on 5/11/2017.
 */

import oracle.kv.*;

import java.sql.SQLException;
import java.util.*;

public class GetSortedMovies {
    public static void main(String[] args) throws SQLException {
        KVStore kvstore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadDB(kvstore);

        getValues(kvstore);
        kvstore.close();
    }

    public static void getValues(KVStore kvstore){
        Key key = Key.createKey(Arrays.asList("movie"));
        Map<Key, ValueVersion> fields = kvstore.multiGet(key, null, null);
        HashMap<String, ArrayList<String>> movies = new HashMap<>();
        ArrayList<String> years = new ArrayList<>();

        String tempname = "";
        String year;

        // Iterate through each item in the populated map from the KVstore
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            // Get the id from each movie
            String movieid = field.getKey().getMinorPath().get(0);

            // get the name and year and store them in temp variables
            tempname = new String(field.getValue().getValue().getValue());
            year = new String(field.getValue().getValue().getValue());
            movies.get(year).add(movieid + "\t" + tempname);
        }

        Collections.sort(years);
        for (String movieyear : years) {
            for (String movie : movies.get(movieyear)) {
                System.out.println(movieyear + "\t" + movie);
            }
        }
    }
}
