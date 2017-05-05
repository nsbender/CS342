import java.util.Arrays;

import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;
import oracle.kv.Value;

/**
 * Created by nsb2 on 5/5/2017.
 */
public class HelloRecords {

    public static void main(String[] args) {

        KVStore movieStore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // C(reate)
        // This initializes an arbitrary key-value pair and stores it in KVLite.
        // The key-value structure is /nameKey : $nameValue
        String nameString = "Dr. Strangelove", yearString = "1964", ratingString = "8.7";

        // Create the new keys, each with the same major key path and heterogeneous minor key paths
        Key nameKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
        Key yearKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
        Key ratingKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rating"));

        // Create the values for the keys from the strings specified above
        Value nameValue = Value.createValue(nameString.getBytes());
        Value yearValue = Value.createValue(yearString.getBytes());
        Value ratingValue = Value.createValue(ratingString.getBytes());

        // Add the keys to the store
        movieStore.put(nameKey, nameValue);
        movieStore.put(ratingKey, ratingValue);
        movieStore.put(yearKey, yearValue);


        // R(ead)
        // This queries KVLite using the same keys.
        // The result, a byte array, is converted into a string.
        System.out.println("New movie record:");
        String nameResult = new String(movieStore.get(nameKey).getValue().getValue());
        String yearResult = new String(movieStore.get(yearKey).getValue().getValue());
        String ratingResult = new String(movieStore.get(ratingKey).getValue().getValue());

        // Print the formatted results from the query
        System.out.println("\t" + nameKey.toString() + " : " + nameResult);
        System.out.println("\t" + yearKey.toString() + " : " + yearResult);
        System.out.println("\t" + ratingKey.toString() + " : " + ratingResult);

        movieStore.close();
    }

}
