package com.example.ProjectForBgd.repo;

import com.example.ProjectForBgd.domain.Record;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RecordRepo extends CrudRepository<Record, Long> {
    List<Record> findByTag(String tag);
}
