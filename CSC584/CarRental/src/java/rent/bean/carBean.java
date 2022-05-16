/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rent.bean;

/**
 *
 * @author MKA
 */
public class carBean implements java.io.Serializable
{
	private String car_plate;
	private String car_name;
	private String car_brand;
	private int car_capacity;
	private double car_rent;
	private double car_mileage;
	private String car_status;

	public carBean() 
	{
		
	}

	public carBean(String car_plate, String car_name, String car_brand, int car_capacity, double car_rent, double car_mileage, String car_status) 
	{
		this.car_plate = car_plate;
		this.car_name = car_name;
		this.car_brand = car_brand;
		this.car_capacity = car_capacity;
		this.car_rent = car_rent;
		this.car_mileage = car_mileage;
		this.car_status = car_status;
	}

	public String getCar_plate() {
		return car_plate;
	}

	public String getCar_name() {
		return car_name;
	}

	public String getCar_brand() {
		return car_brand;
	}

	public int getCar_capacity() {
		return car_capacity;
	}

	public double getCar_rent() {
		return car_rent;
	}

	public String getCar_status() {
		return car_status;
	}

	public double getCar_mileage() {
		return car_mileage;
	}
	
	public void setCar_plate(String car_plate) {
		this.car_plate = car_plate;
	}

	public void setCar_name(String car_name) {
		this.car_name = car_name;
	}

	public void setCar_brand(String car_brand) {
		this.car_brand = car_brand;
	}

	public void setCar_capacity(int car_capacity) {
		this.car_capacity = car_capacity;
	}

	public void setCar_rent(double car_rent) {
		this.car_rent = car_rent;
	}

	public void setCar_status(String car_status) {
		this.car_status = car_status;
	}

	public void setCar_mileage(double car_mileage) {
		this.car_mileage = car_mileage;
	}
	
	public boolean checkSearch(String s_number, String s_brand, String s_cap)
	{
		if( s_number == null || s_number.trim().length() == 0)
		{
			s_number = "" + Integer.MIN_VALUE;
        }
		
		if( s_brand == null || s_brand.trim().length() == 0)
		{
			s_brand = "";
        }
		
		if( s_cap == null || s_cap.trim().length() == 0)
		{
			s_cap = "" + Integer.MAX_VALUE;
        }
		
		if(this.car_rent <= Double.parseDouble(s_number))
			return true;
		if(this.car_brand.equals(s_brand))
			return true;
		if(this.car_capacity >= Integer.parseInt(s_cap))
			return true;
		
		return false;
	}
}
