package com.gdj35.art.web.user.dao;

import java.util.HashMap;
import java.util.List;

public interface IManagerDao {

	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable;

	public int getTCnt(HashMap<String, String> params) throws Throwable;

	

	public List<HashMap<String, String>> getPostList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getGList(HashMap<String, String> params) throws Throwable;


	public HashMap<String, String> getUserDetail(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getUser(HashMap<String, String> params)throws Throwable;


	public int getGallaryMCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDPList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> outUserList(HashMap<String, String> params)throws Throwable;

	public int getOutCnt(HashMap<String, String> params)throws Throwable;

	public int deleteOneRow(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getDMList(HashMap<String, String> params)throws Throwable;

	public int updateUser(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getTList(HashMap<String, String> params)throws Throwable;

	public int updatePostDetail(HashMap<String, String> params) throws Throwable;

	public int getReportMCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getReportList(HashMap<String, String> params) throws Throwable;

	public int deleteG(HashMap<String, String> params) throws Throwable;

	public int getTagCnt(HashMap<String, String> params) throws Throwable;

	public int addTag(HashMap<String, String> params)throws Throwable;

	public int delTag(HashMap<String, String> params)throws Throwable;

	public int returnG(HashMap<String, String> params) throws Throwable;

	public int deleteR(HashMap<String, String> params) throws Throwable;
	
	public int returnR(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getReportDetail(HashMap<String, String> params) throws Throwable;

	public int getGongCnt(HashMap<String, String> params) throws Throwable;

	public int gongRowsDel(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getReportMemo(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMemoDetail(HashMap<String, String> params) throws Throwable;

	public int updateReportMemo(HashMap<String, String> params) throws Throwable;

	public int deleteReportMemo(HashMap<String, String> params) throws Throwable;

	public int addGong(HashMap<String, String> params)throws Throwable;

	public int addMemo(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getNotice(HashMap<String, String> params)throws Throwable;

	public int updateGong(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getMailUser(HashMap<String, String> params)throws Throwable;

	public int updateReport(HashMap<String, String> params)throws Throwable;

	public int addMemoHD(HashMap<String, String> params)throws Throwable;

	public int updateMemo(HashMap<String, String> params)throws Throwable;

	
}
