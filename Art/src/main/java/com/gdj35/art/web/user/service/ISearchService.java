package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

public interface ISearchService {

	public int getSCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getSearchList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getWriterList(HashMap<String, String> params) throws Throwable;

	public int getWCnt(HashMap<String, String> params) throws Throwable;

}
