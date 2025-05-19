package com.restaurant.utils;

import com.restaurant.model.Hotel;

import java.io.*;
import java.util.*;

public class FileUtil {

    /**
     * Reads hotel data from a file and returns a list of Hotel objects.
     * File format: name|description|location|imageUrl|feature1,feature2,...
     */
    public static List<Hotel> readHotelsFromFile(String filePath) {
        List<Hotel> hotels = new ArrayList<>();

        File file = new File(filePath);
        if (!file.exists()) {
            return hotels; // Return empty if file doesn't exist
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 5) {
                    String name = parts[0];
                    String description = parts[1];
                    String location = parts[2];
                    String imageUrl = parts[3];
                    List<String> features = Arrays.asList(parts[4].split(","));

                    Hotel hotel = new Hotel(name, description, location, imageUrl, features);
                    hotels.add(hotel);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return hotels;
    }

    /**
     * Writes the given list of hotels to the specified file.
     * Format per line: name|description|location|imageUrl|feature1,feature2,...
     */
    public static void writeHotelsToFile(List<Hotel> hotels, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Hotel hotel : hotels) {
                String line = String.join("|",
                        hotel.getName(),
                        hotel.getDescription(),
                        hotel.getLocation(),
                        hotel.getImageUrl(),
                        String.join(",", hotel.getFeatures())
                );
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
