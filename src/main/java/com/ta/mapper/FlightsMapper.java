package com.ta.mapper;

import java.util.List;
import java.util.Map;

public interface FlightsMapper {
    /**
     *
     * get all Flights
     *
     */
    List<Map<String, Object>> getFlightsList();
}
