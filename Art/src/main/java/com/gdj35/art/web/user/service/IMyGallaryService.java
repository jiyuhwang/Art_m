package com.gdj35.art.web.user.service;

import java.util.HashMap;
import java.util.List;

public interface IMyGallaryService {

	public int addPost(HashMap<String, String> params) throws Throwable;

	public int getNum() throws Throwable;

	public List<HashMap<String, String>> picList(HashMap<String, String> params) throws Throwable;

	public int getPicCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> drawList(HashMap<String, String> params) throws Throwable;

	public int getDrawCnt(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getPost(HashMap<String, String> params) throws Throwable;

	public int updatePost(HashMap<String, String> params) throws Throwable;

	public int deletePost(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> myPicList(HashMap<String, String> params) throws Throwable;
	
	public int getMyPicCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> myDrawList(HashMap<String, String> params) throws Throwable;
	
	public int getMyDrawCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> otherPicList(HashMap<String, String> params) throws Throwable;

	public int getOtherPicCnt(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, String>> otherDrawList(HashMap<String, String> params) throws Throwable;

	public int getOtherDrawCnt(HashMap<String, String> params) throws Throwable;

	public int postOnHeart(HashMap<String, String> params) throws Throwable;

	public int postOffHeart(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> postLikeCnt(HashMap<String, String> params) throws Throwable;

	public int authorOnHeart(HashMap<String, String> params) throws Throwable;

	public int authorOffHeart(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> authorLikeCnt(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> authorIsHeart(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> authorLikeCnt2(HashMap<String, String> params) throws Throwable;

	public void updateViews(HashMap<String, String> params) throws Throwable;

	public int addComment(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> commentList(HashMap<String, String> params) throws Throwable;

	public int addReplyComment(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> videoList(HashMap<String, String> params) throws Throwable;

	public int getVideoCnt(HashMap<String, String> params) throws Throwable;

	public int getMyVideoCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> myVideoList(HashMap<String, String> params) throws Throwable;

	public int getOtherVideoCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> otherVideoList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> postCommentCnt(HashMap<String, String> params) throws Throwable;

	public int getCommentCnt(HashMap<String, String> params) throws Throwable;

	public int deleteComment(HashMap<String, String> params) throws Throwable;

	public int deleteReplyComment(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> mainPicList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> mainDrawList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> mainVideoList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> chart(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> followerList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> followingList(HashMap<String, String> params) throws Throwable;

	public int followerCnt(HashMap<String, String> params) throws Throwable;

	public int followingCnt(HashMap<String, String> params) throws Throwable;

	public int addReport(HashMap<String, String> params) throws Throwable;

	public int reportSeq(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getComment(HashMap<String, String> params) throws Throwable;

	public int addCReport(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> replyCommentList(HashMap<String, String> params) throws Throwable;






}
