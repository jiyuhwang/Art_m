package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

public interface IMemberService {

	public int addUser(HashMap<String, String> params) throws Throwable;

	public int idCheck(HashMap<String, String> params) throws Throwable;

	public int nicknameCheck(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getUser(HashMap<String, String> params) throws Throwable;

	public int updateProfile(HashMap<String, String> params) throws Throwable;

	public int updateSet(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getUser2(HashMap<String, String> params) throws Throwable;

	public int outUser(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> idFind(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> pwFind(HashMap<String, String> params) throws Throwable;

	public int updatePw(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getAdmin(HashMap<String, String> params) throws Throwable;

	public int editPw(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> reportPost(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> reportComment(HashMap<String, String> params) throws Throwable;

	public int deleteMyReport(HashMap<String, String> params) throws Throwable;

	public int getMyReportPostCnt(HashMap<String, String> params) throws Throwable;

	public int getMyReportCommentCnt(HashMap<String, String> params) throws Throwable;

	public int pwCheck(HashMap<String, String> params) throws Throwable;

	public int changeMyReport(HashMap<String, String> params) throws Throwable;
	


}
