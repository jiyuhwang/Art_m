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
		sqlSession.delete("Post.deleteTag", params); // POST_NO와 연결되어 있는 태그들을 지운다.
		
		String tag = params.get("tag"); // 키가 "tag"인 것의 값을 문자열 tag에 담는다.
		
		if(tag != null && tag != "") {
			
			String[] tagArt = tag.split(","); // 문자열 tag를 ',' 기준으로 나누어 배열에 담는다.
			
			for(int i = 0; i < tagArt.length; i++) { // 0부터 배열 tagArt 크기만큼 돌린다.
				
				String tagName = tagArt[i]; // 문자열 tagName에 배열 tagArt[i]의 값을 담는다.
				
				HashMap<String, String> tag2 = sqlSession.selectOne("Post.getTag", tagName); // 문자열 tagName을 getTag쿼리 값(#{tagName})으로 넣고 TAG_NO을 받아온다.
				// tag2의 키 : TAG_NO, 값 : 숫자
	
				if(tag2 != null) { // 등록되어 있는 태그이면
					params.put("TagNo", String.valueOf(tag2.get("TAG_NO"))); // tag2에서 키가 "TAG_NO"인 것의 값을 params의 키가 "TagNo"인 것의 값에 집어넣는다.
					sqlSession.insert("Post.addMiddleTag", params); // 중계 테이블에 #{postNo}, #{TagNo}를 집어넣는다.
				} else { // 등록되어 있지않은 태그이면
					sqlSession.insert("Post.addTag", tagName); // 태그 테이블에 문자열 tagName을 집어넣는다.
					tag2 = sqlSession.selectOne("Post.getTag", tagName); // 문자열 tagName을 getTag쿼리 값(#{tagName})으로 넣고 TAG_NO을 받아온다.
					// tag2의 키 : TAG_NO, 값 : 숫자
					params.put("TagNo", String.valueOf(tag2.get("TAG_NO"))); // tag2에서 키가 "TAG_NO"인 것의 값을 params의 키가 "TagNo"인 것의 값에 집어넣는다.
					sqlSession.insert("Post.addMiddleTag", params); // 중계 테이블에 #{postNo}, #{TagNo}를 집어넣는다.
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
		System.out.println("이거 체크 박스 배열 값이여" + params);
		System.out.println(params.get("noticeNo") instanceof String);// 스크링값
		
		int cnt =0;
		String noticeNos = params.get("noticeNo");
		String[] arr = noticeNos.split(",");//{}없이도 배열에 적용이 가능한 것 같다.
		
		System.out.println("받아온 배열값"+Arrays.toString(arr));
		System.out.println(arr.length);
	
			for(int i =0; i < arr.length; i++) {
				params.put("noticeNo", arr[i]);
				System.out.println("포문 배열 찍기"+params.get("noticeNo"));
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
		System.out.println("이거 다오에 파람즈"+params);
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
			System.out.println("이거는 arr[i]야"+arr[i]);
			finalList.add(sqlSession.selectOne("Manager.getMailUser", arr[i]));
		}
		
		System.out.println("이거는 finalList야"+finalList);
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
