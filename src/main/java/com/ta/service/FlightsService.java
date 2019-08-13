package com.ta.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ta.mapper.FlightsMapper;

import java.util.List;
import java.util.Map;

@Service
public class FlightsService {

    @Autowired
	FlightsMapper flightsMapper;

	public List<Map<String, Object>> getFlightsList() {
		return flightsMapper.getFlightsList();
	}
}