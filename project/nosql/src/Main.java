import java.sql.*;
import java.util.*;

import oracle.kv.*;

/**
 * Created by nsb2 on 5/5/2017.
 */
public class Main {

    public static void main(String[] args) throws SQLException{
        KVStore beerStore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        loadData(beerStore);
        queryData(beerStore);
        beerStore.close();
    }

    public static void loadData(KVStore kvstore) throws SQLException{
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@//localhost:1521/XE", "beerdb", "bjarne");

        loadBeer(kvstore, jdbcConnection);
        loadBreweries(kvstore, jdbcConnection);
        loadDistributors(kvstore, jdbcConnection);

        jdbcConnection.close();
    }

    public static void loadBeer(KVStore kvstore, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, breweryId, variety, ibu, inProduction, introduced, abv FROM Beer");
        while (resultSet.next()) {
            // Print current beer
            System.out.println(resultSet.getString(1) + ", " + resultSet.getString(2) + ", " + resultSet.getString(3)
                + ", " + resultSet.getString(4) + ", " + resultSet.getString(5) + ", " + resultSet.getString(6)
                + ", " + resultSet.getString(7) + ", " + resultSet.getString(8));

            // Store beer name
            if (resultSet.getString(2) != null) {
                Key nameKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "name"));
                Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
                kvstore.put(nameKey, nameValue);
            }
            // Store breweryId
            Key breweryKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "breweryId"));
            Value breweryValue = Value.createValue(resultSet.getString(3).getBytes());
            kvstore.put(breweryKey, breweryValue);
            // Store beer variety
            if (resultSet.getString(4) != null) {
                Key varietyKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "variety"));
                Value varietyValue = Value.createValue(resultSet.getString(4).getBytes());
                kvstore.put(varietyKey, varietyValue);
            }
            // Store beer IBU
            if (resultSet.getString(5) != null) {
                Key ibuKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "ibu"));
                Value ibuValue = Value.createValue(resultSet.getString(5).getBytes());
                kvstore.put(ibuKey, ibuValue);
            }
            // Store beer production status
            if (resultSet.getString(6) != null) {
                Key inproductionKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "inProduction"));
                Value inproductionValue = Value.createValue(resultSet.getString(6).getBytes());
                kvstore.put(inproductionKey, inproductionValue);
            }
            // Store introduction date
            if (resultSet.getString(7) != null) {
                Key introducedKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "introduced"));
                Value introducedValue = Value.createValue(resultSet.getString(7).getBytes());
                kvstore.put(introducedKey, introducedValue);
            }
            // Store ABV
            Key abvKey = Key.createKey(Arrays.asList("beer"), Arrays.asList(resultSet.getString(1), "abv"));
            Value abvValue = Value.createValue(resultSet.getString(8).getBytes());
            kvstore.put(abvKey, abvValue);
        }
    }

    public static void loadBreweries(KVStore kvstore, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, yearFounded, country, city, parentId, website FROM Brewery");
        while (resultSet.next()) {
            // Print current brewery
            System.out.println(resultSet.getString(1) + ", " + resultSet.getString(2) + ", " + resultSet.getString(3)
                    + ", " + resultSet.getString(4) + ", " + resultSet.getString(5) + ", " + resultSet.getString(6)
                    + ", " + resultSet.getString(7));

            // Store brewery name
            Key nameKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "name"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            kvstore.put(nameKey, nameValue);
            // Store founding date
            if (resultSet.getString(3) != null) {
                Key foundingKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "yearFounded"));
                Value foundingValue = Value.createValue(resultSet.getString(3).getBytes());
                kvstore.put(foundingKey, foundingValue);
            }
            // Store founding date
            Key countryKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "country"));
            Value countryValue = Value.createValue(resultSet.getString(4).getBytes());
            kvstore.put(countryKey, countryValue);
            // Store city
            Key cityKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "city"));
            Value cityValue = Value.createValue(resultSet.getString(5).getBytes());
            kvstore.put(cityKey, cityValue);
            // Store parent Company ID
            if (resultSet.getString(6) != null) {
                Key parentKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "parentId"));
                Value parentValue = Value.createValue(resultSet.getString(6).getBytes());
                kvstore.put(parentKey, parentValue);
            }
            // Store brewery website address
            if (resultSet.getString(6) != null) {
                Key addressKey = Key.createKey(Arrays.asList("brewery"), Arrays.asList(resultSet.getString(1), "website"));
                Value addressValue = Value.createValue(resultSet.getString(6).getBytes());
                kvstore.put(addressKey, addressValue);
            }
        }
    }

    public static void loadDistributors(KVStore kvstore, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, yearFounded, country, city, parentId, website FROM Brewery");
        while (resultSet.next()) {
            // Print current distributor
            System.out.println(resultSet.getString(1) + ", " + resultSet.getString(2) + ", " + resultSet.getString(3));

            // Store distributor name
            Key nameKey = Key.createKey(Arrays.asList("distributor"), Arrays.asList(resultSet.getString(1), "name"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            kvstore.put(nameKey, nameValue);
            // Store founding date
            Key addressKey = Key.createKey(Arrays.asList("distributor"), Arrays.asList(resultSet.getString(1), "address"));
            Value addressValue = Value.createValue(resultSet.getString(3).getBytes());
            kvstore.put(addressKey, addressValue);
        }
    }

    public static void queryData(KVStore kvstore){
        Key key = Key.createKey(Arrays.asList("brewery"), Arrays.asList());

        getBreweriesOrderedByYear(kvstore);
        getBreweryBeers(kvstore);
    }

    public static void getBreweriesOrderedByYear(KVStore store){
        System.out.println("Retrieving breweries by their age...\n");

        // Create the temporary major key
        Key key = Key.createKey(Arrays.asList("brewery"), Arrays.asList());

        HashMap<String, ArrayList<String>> breweries = new HashMap<>();
        HashMap<String, ArrayList<String>> dates = new HashMap<>();
        ArrayList<String> sortableDates = new ArrayList<>();

        // Retrieve each of the breweries and store them in a map
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        // Temp string for examining breweries
        String breweryId;

        // For each brewery loaded into the map, get its date and add it to the sortable dates
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            // Split the field by slashes, since the that is how values are stored
            breweryId = field.getKey().toString().split("/")[3];
            // If the breweries map doesn't already have this brewery, add it
            if (!breweries.containsKey(breweryId)){
                breweries.put(breweryId, new ArrayList<>());
            }
            // Get the key & data that isn't the id
            String otherDataKey = field.getKey().toString().split("/")[4];
            String value = new String(field.getValue().getValue().getValue());
            // Check for the data we want (breweryId and year)
            if (otherDataKey.equals("name")){
                breweries.get(breweryId).add(value);
            }
            // Associate each brewery with a date and add unique dates to the to-be-sorted list
            else if (otherDataKey.equals("yearFounded")){
                if (! dates.containsKey(value)) {
                    dates.put(value, new ArrayList<>());
                    sortableDates.add(value);
                }
                dates.get(value).add(breweryId);
            }
        }

        // Now sort the sortable list and print in order
        Collections.sort(sortableDates);
        for (String d : sortableDates) {
            System.out.println(d);
            for (String brewery : dates.get(d)) {
                ArrayList<String> p = breweries.get(brewery);
                System.out.println("\t" + brewery + ": " + p.get(0));
            }
        }
    }

    public static void getBreweryBeers(KVStore store){
        System.out.println("Retrieving beers by brewery...\n");
        String brewery = new String(store.get(Key.createKey(Arrays.asList("brewery"),
            Arrays.asList("1", "name"))).getValue().getValue());
        System.out.print("Brewery: " + brewery +"\n Beers:\n");

        Key key = Key.createKey(Arrays.asList("brewery"), Arrays.asList("1", "beers"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String beers = new String(field.getValue().getValue().getValue());
            String[] beersArray = beers.split(", ");
            for (String b : beersArray) {
                String beerName = new String(store.get(Key.createKey(Arrays.asList("beer"), Arrays.asList(b, "name"))).getValue().getValue());
                System.out.println("\t" + b + "\t" + beerName);
            }
        }

    }
}
