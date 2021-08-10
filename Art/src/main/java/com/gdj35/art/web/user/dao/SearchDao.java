package com.gdj35.art.web.user.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SearchDao implements ISearchDao{

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getSCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Srh.getSCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getSearchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Srh.getSearchList",params);
	}

	@Override
	public List<HashMap<String, String>> getWriterList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Srh.getWriterList",params);
	}

	@Override
	public int getWCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Srh.getWCnt",params);
	}

}
