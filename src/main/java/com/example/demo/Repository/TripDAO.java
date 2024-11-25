package com.example.demo.Repository;

import com.example.demo.model.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TripDAO extends JpaRepository<Trip,Long> {

    List<Trip> findByDriverId(Long driverId);
}
