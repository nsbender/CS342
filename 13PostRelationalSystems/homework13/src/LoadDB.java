/**
 * Created by nsb2 on 5/11/2017.
 */

import oracle.kv.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class LoadDB {

    public static void main(String[] args) throws SQLException {

        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        KVStore kvstore = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        getMovies(jdbcConnection, kvstore);
        getActors(jdbcConnection, kvstore);
        getRoles(jdbcConnection, kvstore);

        jdbcConnection.close();
        kvstore.close();
    }

    public static void getMovies(Connection jdbcConnection, KVStore kvstore) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultMovies = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");
        // Load each of the rows from the result query into the KVstore
        while (resultMovies.next()) {
            Key keyName = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultMovies.getString(1), "name")); //WHY THE HECK ARE ARRAYS ADDRESSED FROM 1, NOT 0!?!?
            Value valueName = Value.createValue(resultMovies.getString(2).getBytes());
            kvstore.put(keyName, valueName);

            Key keyYear = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultMovies.getString(1), "year"));
            Value valueYear = Value.createValue(resultMovies.getString(3).getBytes());
            kvstore.put(keyYear, valueYear);

            Key keyRank = Key.createKey(Arrays.asList("movie"), Arrays.asList( resultMovies.getString(1), "rank"));
            String rank = resultMovies.getString(4);
            Value valueRank = Value.createValue("".getBytes());
            if (rank != null) {
                valueRank = Value.createValue(resultMovies.getString(4).getBytes());
            }
            kvstore.put(keyRank, valueRank);
        }
        // End the connection to the DB after the keys are created
        resultMovies.close();
        jdbcStatement.close();
    }

    public static void getActors(Connection jdbcConnection, KVStore kvstore) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultActors = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Actor");
        // Load each of the rows from the result query into the KVstore
        while (resultActors.next()) {
            Key keyFirstname = Key.createKey(Arrays.asList("actor", resultActors.getString(1)), Arrays.asList("firstname"));
            Value valueFirstname = Value.createValue(resultActors.getString(2).getBytes());
            kvstore.put(keyFirstname, valueFirstname);
            Key keyLastname = Key.createKey(Arrays.asList("actor", resultActors.getString(1)), Arrays.asList("lastname"));
            Value valueLastname = Value.createValue(resultActors.getString(3).getBytes());
            kvstore.put(keyLastname, valueLastname);        }
        // End the connection to the DB after the keys are created
        resultActors.close();
        jdbcStatement.close();
    }

    public static void getRoles(Connection jdbcConnection, KVStore kvstore) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultRoles = jdbcStatement.executeQuery("SELECT actorId, movieId, role FROM Role");

        ArrayList<Key> actorKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> actorValues = new ArrayList<>();
        ArrayList<Key> movieKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> movieValues = new ArrayList<>();

        // Load each of the rows from the result query into the KVstore
        while (resultRoles.next()) {
            Key keyActor = Key.createKey(Arrays.asList("movie", resultRoles.getString(2)), Arrays.asList("actors", resultRoles.getString(1)));
            if (!actorKeys.contains(keyActor)) {
                actorKeys.add(keyActor);
                actorValues.add(new ArrayList<>());
            }

            actorValues.get(actorKeys.indexOf(keyActor)).add(resultRoles.getString(3) + ":");

            Key keyMovie = Key.createKey(Arrays.asList("actor", resultRoles.getString(1)), Arrays.asList("movies", resultRoles.getString(2)));
            if (!movieKeys.contains(keyMovie)) { // If this is a movie I haven't seen yet
                movieKeys.add(keyMovie);
                movieValues.add(new ArrayList<>());
            }
            // Add the role to the list of movies for this actor
            movieValues.get(movieKeys.indexOf(keyMovie)).add(resultRoles.getString(3) + ":");}

        for (int i = 0; i < actorKeys.size(); i++) {
            String val = actorValues.get(i).toString();
            kvstore.put(actorKeys.get(i), Value.createValue(val.substring(1, val.length()-2).getBytes()));
        }
        for (int i = 0; i < movieKeys.size(); i++) {
            String val = movieValues.get(i).toString();
            kvstore.put(movieKeys.get(i), Value.createValue(val.substring(1, val.length()-2).getBytes()));
        }

        // End the connection to the DB after the keys are created
        resultRoles.close();
        jdbcStatement.close();
    }

}
