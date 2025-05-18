package com.restaurant.model;

public class Reservation {
    private String reservationId;
    private String HotelName;
    private String date;
    private String time;
    private int guests;
    private String name;
    private String email;
    private String phone;
    private String tableType;

    public Reservation(String reservationId, String HotelName, String date, String time,
                       int guests, String name, String email, String phone, String tableType) {
        this.reservationId = reservationId;
        this.HotelName = HotelName;
        this.date = date;
        this.time = time;
        this.guests = guests;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.tableType = tableType;
    }

    public Reservation(String restaurant, String date, String time, int guests, String name, String email) {
        this.reservationId = "RES" + System.currentTimeMillis();
        this.HotelName = restaurant;
        this.date = date;
        this.time = time;
        this.guests = guests;
        this.name = name;
        this.email = email;
        this.phone = "";
        this.tableType = "";
    }

    public String getReservationId() {
        return reservationId;
    }

    public String getHotelName() {
        return HotelName;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public int getGuests() {
        return guests;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String gettableType(){
        return tableType;
    }

    public String toFileString() {
        return reservationId + "," + HotelName + "," + date + "," + time + "," + guests + "," + name + "," + email + "," + phone + "," + tableType;
    }
}
