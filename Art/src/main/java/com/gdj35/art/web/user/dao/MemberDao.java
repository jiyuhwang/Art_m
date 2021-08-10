package com.gdj35.art.web.user.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao implements IMemberDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int addUser(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("User.addUser", params);
	}

	@Override
	public int idCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.idCheck", params);
	}

	@Override
	public int nicknameCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.nicknameCheck", params);
	}

	@Override
	public HashMap<String, String> getUser(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.getUser", params);
	}

	@Override
	public int updateProfile(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.updateProfile", params);
	}

	@Override
	public int updateSet(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.updateSet", params);
	}

	@Override
	public HashMap<String, String> getUser2(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.getUser2", params);
	}

	@Override
	public int outUser(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.outUser", params);
	}

	@Override
	public List<HashMap<String, String>> idFind(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("User.idFind", params);
	}

	@Override
	public HashMap<String, String> pwFind(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.pwFind", params);
	}

	@Override
	public int updatePw(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.updatePw", params);
	}

	@Override
	public HashMap<String, String> getAdmin(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.getAdmin", params);
	}

	@Override
	public int editPw(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.editPw", params);
	}

	@Override
	public List<HashMap<String, String>> reportPost(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("User.reportPost", params);
	}

	@Override
	public List<HashMap<String, String>> reportComment(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("User.reportComment", params);
	}

	@Override
	public int deleteMyReport(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.deleteMyReport", params);
	}

	@Override
	public int getMyReportPostCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.getMyReportPostCnt", params);
	}

	@Override
	public int getMyReportCommentCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.getMyReportCommentCnt", params);
	}

	@Override
	public int pwCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("User.pwCheck", params);
	}

	@Override
	public int changeMyReport(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("User.changeMyReport", params);
	}


}
