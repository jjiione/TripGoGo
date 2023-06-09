package com.tripgogo.mytrip.model.service;

import com.tripgogo.mytrip.model.PlaceDto;
import com.tripgogo.mytrip.model.dao.PlaceDao;
import com.tripgogo.mytrip.model.dao.PlaceDaoImpl;

import java.sql.Date;
import java.util.List;

public class PlaceServiceImpl implements PlaceService {
    private PlaceDao placeDao;
    private static PlaceService placeService = new PlaceServiceImpl();

    private PlaceServiceImpl() {
        placeDao = PlaceDaoImpl.getInstance();
    }

    public static PlaceService getInstance() {
        return placeService;
    }

    @Override
    public List<PlaceDto> getPlaces(int myTripId) throws Exception {
        return placeDao.getPlaces(myTripId);
    }

    @Override
    public void deletePlaces(List<Integer> placeIds) throws Exception {
        placeDao.deletePlaces(placeIds);
    }

    @Override
    public void addPlace(PlaceDto placeDto) throws Exception {
        placeDao.addPlace(placeDto);
    }

    @Override
    public List<PlaceDto> getPlaceByDate(long myTripId, Date date) throws Exception {
        return placeDao.getPlaceByDate(myTripId, date);
    }
}
