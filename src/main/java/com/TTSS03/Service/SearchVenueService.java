package com.TTSS03.Service;

import java.util.List;

import com.TTSS03.Entity.SearchVenue;

public interface SearchVenueService {
	List<SearchVenue> findByVenueid(long vid);

	List<SearchVenue>findAllVenue(SearchVenue searchVenue);

	
	
	SearchVenue saveOnevenue (SearchVenue Searchvenue);
	
	 void updatevenue(long vid,SearchVenue Searchvenue);
	    
	    void deActivatevenue(long vid);

	
	

}
