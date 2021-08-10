package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj35.art.web.user.dao.ISearchDao;

@Service
public class SearchService implements ISearchService{
	@Autowired
	public ISearchDao iSearchDao;

	@Override
	public int getSCnt(HashMap<String, String> params) throws Throwable {
		return iSearchDao.getSCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getSearchList(HashMap<String, String> params) throws Throwable {
		return iSearchDao.getSearchList(params);
	}

	@Override
	public List<HashMap<String, String>> getWriterList(HashMap<String, String> params) throws Throwable {
		return iSearchDao.getWriterList(params);
	}

	@Override
	public int getWCnt(HashMap<String, String> params) throws Throwable {
		return iSearchDao.getWCnt(params);
	}

}
