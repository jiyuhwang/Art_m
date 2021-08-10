package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj35.art.web.user.dao.IMemberDao;

@Service
public class MemberService implements IMemberService{
	@Autowired
	public IMemberDao iMemberDao;

	@Override
	public int addUser(HashMap<String, String> params) throws Throwable {
		return iMemberDao.addUser(params);
	}

	@Override
	public int idCheck(HashMap<String, String> params) throws Throwable {
		return iMemberDao.idCheck(params);
	}

	@Override
	public int nicknameCheck(HashMap<String, String> params) throws Throwable {
		return iMemberDao.nicknameCheck(params);
	}

	@Override
	public HashMap<String, String> getUser(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getUser(params);
	}

	@Override
	public int updateProfile(HashMap<String, String> params) throws Throwable {
		return iMemberDao.updateProfile(params);
	}

	@Override
	public int updateSet(HashMap<String, String> params) throws Throwable {
		return iMemberDao.updateSet(params);
	}

	@Override
	public HashMap<String, String> getUser2(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getUser2(params);
	}

	@Override
	public int outUser(HashMap<String, String> params) throws Throwable {
		return iMemberDao.outUser(params);
	}

	@Override
	public List<HashMap<String, String>> idFind(HashMap<String, String> params) throws Throwable {
		return iMemberDao.idFind(params);
	}

	@Override
	public HashMap<String, String> pwFind(HashMap<String, String> params) throws Throwable {
		return iMemberDao.pwFind(params);
	}

	@Override
	public int updatePw(HashMap<String, String> params) throws Throwable {
		return iMemberDao.updatePw(params);
	}

	@Override
	public HashMap<String, String> getAdmin(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getAdmin(params);
	}

	@Override
	public int editPw(HashMap<String, String> params) throws Throwable {
		return iMemberDao.editPw(params);
	}

	@Override
	public List<HashMap<String, String>> reportPost(HashMap<String, String> params) throws Throwable {
		return iMemberDao.reportPost(params);
	}

	@Override
	public List<HashMap<String, String>> reportComment(HashMap<String, String> params) throws Throwable {
		return iMemberDao.reportComment(params);
	}

	@Override
	public int deleteMyReport(HashMap<String, String> params) throws Throwable {
		return iMemberDao.deleteMyReport(params);

	}

	@Override
	public int getMyReportPostCnt(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getMyReportPostCnt(params);
	}

	@Override
	public int getMyReportCommentCnt(HashMap<String, String> params) throws Throwable {
		return iMemberDao.getMyReportCommentCnt(params);
	}

	@Override
	public int pwCheck(HashMap<String, String> params) throws Throwable {
		return iMemberDao.pwCheck(params);
	}

	@Override
	public int changeMyReport(HashMap<String, String> params) throws Throwable {
		return iMemberDao.changeMyReport(params);
	}

}
