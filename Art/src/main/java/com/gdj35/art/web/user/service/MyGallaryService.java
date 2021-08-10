package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj35.art.web.user.dao.IMyGallaryDao;

@Service
public class MyGallaryService implements IMyGallaryService{
	@Autowired
	public IMyGallaryDao iMyGallaryDao;

	@Override
	public int addPost(HashMap<String, String> params) throws Throwable {
		
		return iMyGallaryDao.addPost(params);
	}

	@Override
	public int getNum() throws Throwable {
		return iMyGallaryDao.getNum();
	}

	@Override
	public List<HashMap<String, String>> picList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.picList(params);
	}

	@Override
	public int getPicCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getPicCnt(params);
	}

	@Override
	public List<HashMap<String, String>> drawList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.drawList(params);
	}

	@Override
	public int getDrawCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getDrawCnt(params);
	}

	@Override
	public HashMap<String, String> getPost(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getPost(params);
	}

	@Override
	public int updatePost(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.updatePost(params);
	}

	@Override
	public int deletePost(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.deletePost(params);
	}

	@Override
	public List<HashMap<String, String>> myPicList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.myPicList(params);
	}
	
	@Override
	public int getMyPicCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getMyPicCnt(params);
	}
	
	@Override
	public List<HashMap<String, String>> myDrawList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.myDrawList(params);
	}

	@Override
	public int getMyDrawCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getMyDrawCnt(params);
	}

	@Override
	public List<HashMap<String, String>> otherPicList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.otherPicList(params);
	}

	@Override
	public int getOtherPicCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getOtherPicCnt(params);
	}
	
	@Override
	public List<HashMap<String, String>> otherDrawList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.otherDrawList(params);
	}

	@Override
	public int getOtherDrawCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getOtherDrawCnt(params);
	}

	@Override
	public int postOnHeart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.postOnHeart(params);
	}

	@Override
	public int postOffHeart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.postOffHeart(params);
	}

	@Override
	public HashMap<String, String> postLikeCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.postLikeCnt(params);
	}

	@Override
	public int authorOnHeart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.authorOnHeart(params);
	}

	@Override
	public int authorOffHeart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.authorOffHeart(params);
	}

	@Override
	public HashMap<String, String> authorLikeCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.authorLikeCnt(params);
	}


	@Override
	public HashMap<String, String> authorIsHeart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.authorIsHeart(params);
	}

	@Override
	public HashMap<String, String> authorLikeCnt2(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.authorLikeCnt2(params);
	}

	@Override
	public void updateViews(HashMap<String, String> params) throws Throwable {
		iMyGallaryDao.updateViews(params);
	}

	@Override
	public int addComment(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.addComment(params);
	}

	@Override
	public List<HashMap<String, String>> commentList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.commentList(params);
	}

	@Override
	public int addReplyComment(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.addReplyComment(params);
	}

	@Override
	public List<HashMap<String, String>> videoList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.videoList(params);
	}

	@Override
	public int getVideoCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getVideoCnt(params);
	}

	@Override
	public int getMyVideoCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getMyVideoCnt(params);
	}

	@Override
	public List<HashMap<String, String>> myVideoList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.myVideoList(params);
	}

	@Override
	public int getOtherVideoCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getOtherVideoCnt(params);
	}

	@Override
	public List<HashMap<String, String>> otherVideoList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.otherVideoList(params);
	}

	@Override
	public HashMap<String, String> postCommentCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.postCommentCnt(params);
	}

	@Override
	public int getCommentCnt(HashMap<String, String> params) throws Throwable {		// TODO Auto-generated method stub
		return iMyGallaryDao.getCommentCnt(params);

	}

	@Override
	public int deleteComment(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.deleteComment(params);

	}

	@Override
	public int deleteReplyComment(HashMap<String, String> params) throws Throwable {		// TODO Auto-generated method stub
		return iMyGallaryDao.deleteReplyComment(params);
	}

	@Override
	public List<HashMap<String, String>> mainPicList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.mainPicList(params);
	}

	@Override
	public List<HashMap<String, String>> mainDrawList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.mainDrawList(params);
	}

	@Override
	public List<HashMap<String, String>> mainVideoList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.mainVideoList(params);
	}

	@Override
	public List<HashMap<String, Object>> chart(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.chart(params);
	}

	@Override
	public List<HashMap<String, String>> followerList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.followerList(params);
	}

	@Override
	public List<HashMap<String, String>> followingList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.followingList(params);
	}

	@Override
	public int followerCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.followerCnt(params);
	}

	@Override
	public int followingCnt(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.followingCnt(params);
	}
	
	@Override
	public int addReport(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.addReport(params);
	}

	@Override
	public int reportSeq(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.reportSeq(params);
	}

	@Override
	public HashMap<String, String> getComment(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.getComment(params);
	}

	@Override
	public int addCReport(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.addCReport(params);
	}

	@Override
	public List<HashMap<String, String>> replyCommentList(HashMap<String, String> params) throws Throwable {
		return iMyGallaryDao.replyCommentList(params);
	}


}
