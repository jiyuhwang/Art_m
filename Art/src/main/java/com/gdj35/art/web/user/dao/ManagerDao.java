package com.gdj35.art.web.user.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ManagerDao implements IManagerDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("Manager.getMList",params);
	}

	@Override
	public int getTCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Manager.getTCnt",params);
	}
	

	@Override
	public List<HashMap<String, String>> getGList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Manager.getGList",params);
	
	}

	@Override
	public HashMap<String, String> getUser(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Manager.getUser",params);
	}

	
	@Override
	public List<HashMap<String, String>> getDPList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("Manager.getDPList",params);
	}
	
	@Override
	public List<HashMap<String, String>> outUserList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("Manager.outUserList",params);
	}
	
	

	
	
	@Override
	public List<HashMap<String, String>> getPostList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Manager.getPostList", params);
	}
	
	@Override
	public HashMap<String, String> getUserDetail(HashMap<String, String> params) throws Throwable {		
		return sqlSession.selectOne("Manager.getUserDetail", params);
	}

	@Override
	public int getGallaryMCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Manager.getGallaryMCnt", params);
	}

	@Override
	public int getOutCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Manager.getOutCnt",params);
	}

	@Override
	public int deleteOneRow(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("Manager.deleteOneRow",params);
	}

	@Override
	public List<HashMap<String, String>> getDMList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Manager.getDMList",params);
	}

	@Override
	public int updateUser(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("Manager.updateUser",params);
	}

	@Override
	public List<HashMap<String, String>> getTList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Manager.getTList",params);
	}

	@Override
	public int updatePostDetail(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("Post.deleteTag", params); // POST_NO??? ???????????? ?????? ???????????? ?????????.
		
		String tag = params.get("tag"); // ?????? "tag"??? ?????? ?????? ????????? tag??? ?????????.
		
		if(tag != null && tag != "") {
			
			String[] tagArt = tag.split(","); // ????????? tag??? ',' ???????????? ????????? ????????? ?????????.
			
			for(int i = 0; i < tagArt.length; i++) { // 0?????? ?????? tagArt ???????????? ?????????.
				
				String tagName = tagArt[i]; // ????????? tagName??? ?????? tagArt[i]??? ?????? ?????????.
				
				HashMap<String, String> tag2 = sqlSession.selectOne("Post.getTag", tagName); // ????????? tagName??? getTag?????? ???(#{tagName})?????? ?????? TAG_NO??? ????????????.
				// tag2??? ??? : TAG_NO, ??? : ??????
	
				if(tag2 != null) { // ???????????? ?????? ????????????
					params.put("TagNo", String.valueOf(tag2.get("TAG_NO"))); // tag2?????? ?????? "TAG_NO"??? ?????? ?????? params??? ?????? "TagNo"??? ?????? ?????? ???????????????.
					sqlSession.insert("Post.addMiddleTag", params); // ?????? ???????????? #{postNo}, #{TagNo}??? ???????????????.
				} else { // ???????????? ???????????? ????????????
					sqlSession.insert("Post.addTag", tagName); // ?????? ???????????? ????????? tagName??? ???????????????.
					tag2 = sqlSession.selectOne("Post.getTag", tagName); // ????????? tagName??? getTag?????? ???(#{tagName})?????? ?????? TAG_NO??? ????????????.
					// tag2??? ??? : TAG_NO, ??? : ??????
					params.put("TagNo", String.valueOf(tag2.get("TAG_NO"))); // tag2?????? ?????? "TAG_NO"??? ?????? ?????? params??? ?????? "TagNo"??? ?????? ?????? ???????????????.
					sqlSession.insert("Post.addMiddleTag", params); // ?????? ???????????? #{postNo}, #{TagNo}??? ???????????????.
				}
		
			}
		}
		
		return sqlSession.update("Manager.updatePostDetail",params);
	}

	@Override
	public int getReportMCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Manager.getReportMCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getReportList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Manager.getReportList", params);
	}

	@Override
	public int deleteG(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.deleteG",params);
	}

	@Override
	public int getTagCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Manager.getTagCnt",params);
	}

	@Override
	public int addTag(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("Manager.addTag",params);
	}

	@Override
	public int delTag(HashMap<String, String> params) throws Throwable {
		int cnt =0;
		String arr = params.get("tagNo");
		String[] arrA = arr.split(",");
		 System.out.println(Arrays.toString(arrA));
		 
		 for(int i =0; i<arrA.length; i++) {
			 params.put("tagNo", arrA[i]);
			 System.out.println(params.get("tagNo"));
			 cnt += sqlSession.update("Manager.delTag",params);
			 params.remove("tagNo");
		 }
		
		
		return cnt;
	}

	@Override
	public int returnG(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.returnG",params);
	}

	@Override
	public int deleteR(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.deleteR",params);
	}

	@Override
	public int returnR(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.returnR",params);
	}

	@Override
	public HashMap<String, String> getReportDetail(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Manager.getReportDetail", params);
	}

	@Override
	public int getGongCnt(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Manager.getGongCnt",params);
	}

	@Override
	public int gongRowsDel(HashMap<String, String> params) throws Throwable {
		System.out.println("?????? ?????? ?????? ?????? ?????????" + params);
		System.out.println(params.get("noticeNo") instanceof String);// ????????????
		
		int cnt =0;
		String noticeNos = params.get("noticeNo");
		String[] arr = noticeNos.split(",");//{}????????? ????????? ????????? ????????? ??? ??????.
		
		System.out.println("????????? ?????????"+Arrays.toString(arr));
		System.out.println(arr.length);
	
			for(int i =0; i < arr.length; i++) {
				params.put("noticeNo", arr[i]);
				System.out.println("?????? ?????? ??????"+params.get("noticeNo"));
				cnt += sqlSession.update("Manager.gongRowsDel",params);
				/* params.remove("noticeNo"); */
			}
			
		
		
		
		return cnt;
	}
	
	@Override
	public List<HashMap<String, String>> getReportMemo(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Manager.getReportMemo", params);
	}

	@Override
	public HashMap<String, String> getMemoDetail(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Manager.getMemoDetail", params);
	}

	@Override
	public int updateReportMemo(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.updateReportMemo",params);
	}

	@Override
	public int deleteReportMemo(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Manager.deleteReportMemo",params);
	}

	@Override
	public int addGong(HashMap<String, String> params) throws Throwable {
		System.out.println("?????? ????????? ?????????"+params);
		return sqlSession.insert("Manager.addGong",params);
	}

	@Override
	public int addMemo(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Manager.addMemo",params);
	}

	@Override
	public HashMap<String, String> getNotice(HashMap<String, String> params) throws Throwable {
		System.out.println(params);
		return sqlSession.selectOne("Manager.getNotice", params);
	}

	@Override
	public int updateGong(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("Manager.updateGong",params);
	}

	@Override
	public List<HashMap<String, String>> getMailUser(HashMap<String, String> params) throws Throwable {
		
		String list = params.get("userNo");
		String[] arr = list.split(",");
		
		List<HashMap<String, String>> finalList = new ArrayList<HashMap<String, String>>();
		
		for(int i = 0; i < arr.length; i++) {
			System.out.println("????????? arr[i]???"+arr[i]);
			finalList.add(sqlSession.selectOne("Manager.getMailUser", arr[i]));
		}
		
		System.out.println("????????? finalList???"+finalList);
		return finalList;
	}

	@Override
	public int updateReport(HashMap<String, String> params) throws Throwable {
		System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>" + params);
		
	if(params.get("newStatus").equals("3")) {
		  if(params.get("postNo").equals("undefined")) {
			  sqlSession.update("Manager.deleteComment", params);
		  } else {
			  sqlSession.update("Manager.deletePost", params);
		  }
	}
		 
		
		return sqlSession.update("Manager.updateReport",params);
	}

	@Override
	public int addMemoHD(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.insert("Manager.addMemoHD",params);
	}

	@Override
	public int updateMemo(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("Manager.updateMemo",params);
	}


	
}
