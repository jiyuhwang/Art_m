package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj35.art.web.user.dao.IManagerDao;

@Service
public class ManagerService implements IManagerService {
	@Autowired
	public IManagerDao iManagerDao;

	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getMList(params);
	}

	@Override
	public int getTCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getTCnt(params);
	}
	
	@Override
	public List<HashMap<String, String>> outUserList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.outUserList(params);
	}



	@Override
	public List<HashMap<String, String>> getGList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getGList(params);
	}


	
	@Override
	public List<HashMap<String, String>> getPostList(HashMap<String, String> params) throws Throwable{
		return iManagerDao.getPostList(params);
	}
	
	@Override
	public HashMap<String, String> getUserDetail(HashMap<String, String> params) throws Throwable {
		return iManagerDao.getUserDetail(params);
		
	}

	@Override
	public HashMap<String, String> getUser(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getUser(params);

	}

	@Override

	public int getGallaryMCnt(HashMap<String, String> params) throws Throwable {		
		return iManagerDao.getGallaryMCnt(params);
	}
	
	@Override
	public List<HashMap<String, String>> getDPList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getDPList(params);

	}

	@Override
	public int getOutCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getOutCnt(params);
	}

	@Override
	public int deleteOneRow(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.deleteOneRow(params);
	}

	@Override
	public List<HashMap<String, String>> getDMList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getDMList(params);
	}

	@Override
	public int updateUser(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.updateUser(params);
	}

	@Override
	public List<HashMap<String, String>> getTList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return  iManagerDao.getTList(params);
	}

	@Override
	public int updatePostDetail(HashMap<String, String> params) throws Throwable {
		return iManagerDao.updatePostDetail(params);
	}

	@Override
	public int getReportMCnt(HashMap<String, String> params) throws Throwable {
		return iManagerDao.getReportMCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getReportList(HashMap<String, String> params) throws Throwable {
		return iManagerDao.getReportList(params);
	}

	@Override
	public int deleteG(HashMap<String, String> params) throws Throwable {
		return iManagerDao.deleteG(params);
	}

	@Override
	public int getTagCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getTagCnt(params);
	}

	@Override
	public int addTag(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.addTag(params);
	}

	@Override
	public int delTag(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.delTag(params);
	}

	@Override
	public int returnG(HashMap<String, String> params) throws Throwable {
		return iManagerDao.returnG(params);
	}

	@Override
	public int deleteR(HashMap<String, String> params) throws Throwable {
		return iManagerDao.deleteR(params);
	}

	@Override
	public int returnR(HashMap<String, String> params) throws Throwable {
		return iManagerDao.returnR(params);
	}

	@Override
	public HashMap<String, String> getReportDetail(HashMap<String, String> params) throws Throwable {
		return iManagerDao.getReportDetail(params);
	}

	@Override
	public int getGongCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getGongCnt(params);
	}

	@Override
	public int gongRowsDel(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.gongRowsDel(params);
	}

	@Override
	public List<HashMap<String, String>> getReportMemo(HashMap<String, String> params) throws Throwable {
		return iManagerDao.getReportMemo(params);
	}

	@Override
	public HashMap<String, String> getMemoDetail(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getMemoDetail(params);
	}

	@Override
	public int updateReportMemo(HashMap<String, String> params) throws Throwable {
		return iManagerDao.updateReportMemo(params);
	}

	@Override
	public int deleteReportMemo(HashMap<String, String> params) throws Throwable {
		return iManagerDao.deleteReportMemo(params);
	}

	@Override
	public int addGong(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.addGong(params);
	}

	@Override
	public int addMemo(HashMap<String, String> params) throws Throwable {
		return iManagerDao.addMemo(params);
	}

	@Override
	public HashMap<String, String> getNotice(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getNotice(params);
	}

	@Override
	public int updateGong(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.updateGong(params);
	}

	@Override
	public List<HashMap<String, String>> getMailUser(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.getMailUser(params);
	}

	@Override
	public int updateReport(HashMap<String, String> params) throws Throwable {
		return iManagerDao.updateReport(params);
	}

	@Override
	public int addMemoHD(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.addMemoHD(params);
	}

	@Override
	public int updateMemo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iManagerDao.updateMemo(params);
	}


	




}
