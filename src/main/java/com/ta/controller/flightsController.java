package com.ta.controller;

import java.util.*;

import com.ta.service.FlightsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@RestController
public class flightsController {
	
    @Autowired
	FlightsService flightsService;

	@RequestMapping(value="/flights",method=RequestMethod.GET,produces="application/json;charset=UTF-8")
	public String getFlights() {
		JsonArray flightsListjsonArray = new JsonArray();
		List<Map<String, Object>> returnFlights = null;
		returnFlights = flightsService.getFlightsList();

		flightsListjsonArray = new JsonParser().parse(new Gson().toJson(returnFlights)).getAsJsonArray();
		return flightsListjsonArray.toString();
	}
}
