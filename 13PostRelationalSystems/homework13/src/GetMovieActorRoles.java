/**
 * Created by nsb2 on 5/11/2017.
 */

import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetMovieActorRoles {
    public static void main(String[] args) throws SQLException {
        KVStore kvstore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadDB(kvstore);

        getValues(kvstore);
        kvstore.close();
    }

    public static void getValues(KVStore kvstore){
        Key majorKey = Key.createKey(Arrays.asList("role", "429719", "92616"));
        Map<Key, ValueVersion> fields = kvstore.multiGet(majorKey, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println(fieldValue);
        }
    }
}
