/**
 * Created by nsb2 on 5/11/2017.
 */

import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetTableValues {
    public static void main(String[] args) throws SQLException {
        KVStore kvstore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadDB(kvstore);

        getValues(kvstore);
        kvstore.close();
    }

    public static void getValues(KVStore kvstore){
        System.out.println("Table: movie\nID: 92616");

        // Specifiy the root/major key in which to look
        Key majorKey = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = kvstore.multiGet(majorKey, null, null);
        String[] info = new String[3];
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println(fieldValue);
        }
        System.out.println("\t" + info[0] + "\n\t" + info[1] + "\n\t" + info[2]);
    }
}
