package com.gdj35.art.web.user.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyGallaryDao implements IMyGallaryDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int addPost(HashMap<String, String> params) throws Throwable {
		
		
		
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
		
		return sqlSession.insert("Post.addPost", params);
	}

	@Override
	public int getNum() throws Throwable {
		return sqlSession.selectOne("Post.getNum");
	}

	@Override
	public List<HashMap<String, String>> picList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.picList", params);
	}

	@Override
	public int getPicCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getPicCnt", params);
	}

	@Override
	public List<HashMap<String, String>> drawList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.drawList", params);
	}

	@Override
	public int getDrawCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getDrawCnt", params);
	}

	@Override
	public HashMap<String, String> getPost(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getPost", params);
	}

	@Override
	public int updatePost(HashMap<String, String> params) throws Throwable {
		
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
		return sqlSession.update("Post.updatePost", params);
	}

	@Override
	public int deletePost(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Post.deletePost", params);
	}
	
	@Override
	public List<HashMap<String, String>> myPicList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.myPicList", params);
	}

	@Override
	public int getMyPicCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getMyPicCnt", params);
	}
	
	@Override
	public List<HashMap<String, String>> myDrawList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.myDrawList", params);
	}

	@Override
	public int getMyDrawCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getMyDrawCnt", params);
	}

	@Override
	public List<HashMap<String, String>> otherPicList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.otherPicList", params);
	}

	@Override
	public int getOtherPicCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getOtherPicCnt", params);
	}

	@Override
	public List<HashMap<String, String>> otherDrawList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.otherDrawList", params);
	}

	@Override
	public int getOtherDrawCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getOtherDrawCnt", params);
	}

	@Override
	public int postOnHeart(HashMap<String, String> params) throws Throwable {
		
		HashMap<String, Object> heart = sqlSession.selectOne("Post.postIsHeart", params);
		
		System.out.println("==============================" + heart);
		
		if(heart != null) {
			sqlSession.delete("Post.postOffHeart", params);
			
			return sqlSession.insert("Post.postOnHeart", params);
		} else {
				
			return sqlSession.insert("Post.postOnHeart", params);		
		}
		
		//return sqlSession.insert("Post.onHeart", params);
	}

	@Override
	public int postOffHeart(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Post.postOffHeart", params);
	}

	@Override
	public HashMap<String, String> postLikeCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.postLikeCnt", params);
	}

	@Override
	public int authorOnHeart(HashMap<String, String> params) throws Throwable {
		
		HashMap<String, Object> heart = sqlSession.selectOne("Post.authorIsHeart", params);
		
		
		if(heart != null) {
			sqlSession.delete("Post.authorOffHeart", params);
			
			return sqlSession.insert("Post.authorOnHeart", params);
		} else {
				
			return sqlSession.insert("Post.authorOnHeart", params);		
		}
	}

	@Override
	public int authorOffHeart(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Post.authorOffHeart", params);
	}

	@Override
	public HashMap<String, String> authorLikeCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.authorLikeCnt", params);
	}
	
	@Override
	public HashMap<String, String> authorIsHeart(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.authorIsHeart", params);
	}

	@Override
	public HashMap<String, String> authorLikeCnt2(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.authorLikeCnt2", params);
	}

	@Override
	public void updateViews(HashMap<String, String> params) throws Throwable {
		sqlSession.update("Post.updateViews", params);
	}

	@Override
	public int addComment(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Post.addComment", params);	
	}

	@Override
	public List<HashMap<String, String>> commentList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.commentList", params);
	}

	@Override
	public int addReplyComment(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Post.addReplyComment", params);
	}

	@Override
	public List<HashMap<String, String>> videoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.videoList", params);
	}

	@Override
	public int getVideoCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getVideoCnt", params);
	}

	@Override
	public int getMyVideoCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getMyVideoCnt", params);

	}

	@Override
	public List<HashMap<String, String>> myVideoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.myVideoList", params);

	}

	@Override
	public int getOtherVideoCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getOtherVideoCnt", params);

	}

	@Override
	public List<HashMap<String, String>> otherVideoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.otherVideoList", params);

	}

	@Override
	public HashMap<String, String> postCommentCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.postCommentCnt", params);
	}

	@Override
	public int getCommentCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.getCommentCnt", params);

	}

	@Override
	public int deleteComment(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Post.deleteComment", params);
	}

	@Override
	public int deleteReplyComment(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Post.deleteReplyComment", params);
	}

	@Override
	public List<HashMap<String, String>> mainPicList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.mainPicList", params);
	}

	@Override
	public List<HashMap<String, String>> mainDrawList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.mainDrawList", params);

	}

	@Override
	public List<HashMap<String, String>> mainVideoList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.mainVideoList", params);

	}

	@Override
	public List<HashMap<String, Object>> chart(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.chart", params);
	}

	@Override
	public List<HashMap<String, String>> followerList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.followerList", params);
	}

	@Override
	public List<HashMap<String, String>> followingList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.followingList", params);
	}

	@Override
	public int followerCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.followerCnt", params);
	}

	@Override
	public int followingCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Post.followingCnt", params);
	}

	
	
	
	
	@Override
	public int addReport(HashMap<String, String> params) throws Throwable {
		
		//신고등록할 NO 가져오기
		int seq = sqlSession.selectOne("Post.reportSeq", params);
		params.put("reportNo", String.valueOf(seq));
		System.out.println(params);
		sqlSession.insert("Post.addReport", params);
		System.out.println("이것은 seq다: " + params);		
		
		
		String check = params.get("checkArr");
		String[] checkList = check.split(",");
		for(int i=0; i<checkList.length; i++) {
			
			System.out.println("이게 왜 안나오냐고 오오오오" + checkList[i]);
		}
		
		for(int i=0; i<checkList.length; i++) {
			String typeNo = checkList[i];
			params.put("typeNo", typeNo);
			sqlSession.insert("Post.addMidReport", params);

			System.out.println(checkList[i]);
		}
		
		return 1;
	}

	@Override
	public int reportSeq(HashMap<String, String> params) throws Throwable {
		return  sqlSession.selectOne("Post.reportSeq", params);
	}

	@Override
	public HashMap<String, String> getComment(HashMap<String, String> params) throws Throwable {
		return  sqlSession.selectOne("Post.getComment", params);
	}

	@Override
	public int addCReport(HashMap<String, String> params) throws Throwable {
		
		//댓글신고등록할  다음NO 가져오기
		int seq = sqlSession.selectOne("Post.reportSeq", params);
		params.put("reportNo", String.valueOf(seq));
		System.out.println(params);
		sqlSession.insert("Post.addCReport", params);
		System.out.println("이것은 seq다: " + params);		
		
		
		String check = params.get("checkArr");
		String[] checkList = check.split(",");
		for(int i=0; i<checkList.length; i++) {
			
		}
		
		for(int i=0; i<checkList.length; i++) {
			String typeNo = checkList[i];
			params.put("typeNo", typeNo);
			sqlSession.insert("Post.addMidReport", params);

			System.out.println(checkList[i]);
		}
		
		return 1;
	}

	@Override
	public List<HashMap<String, String>> replyCommentList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Post.replyCommentList", params);
	}

}
