package com.gdj35.art.web.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj35.art.common.bean.PagingBean;
import com.gdj35.art.common.service.IPagingService;
import com.gdj35.art.web.user.service.IMemberService;
import com.gdj35.art.web.user.service.IMyGallaryService;

@Controller
public class MyGallaryController {

	@Autowired
	public IMyGallaryService iMyGallaryService;

	@Autowired
	public IMemberService iMemberService;

	@Autowired
	public IPagingService iPagingService;

	// 로그인 했을 시 상단
	@RequestMapping(value = "/header")
	public ModelAndView header(ModelAndView mav) {
		mav.setViewName("JY/header");

		return mav;
	}
	
	// 로그인 안했을 시 상단
	@RequestMapping(value = "/header2")
	public ModelAndView header2(ModelAndView mav) {
		mav.setViewName("JY/header2");

		return mav;
	}

	// 하단
	@RequestMapping(value = "/footer")
	public ModelAndView footer(ModelAndView mav) {
		mav.setViewName("JY/footer");

		return mav;
	}
	
	
	// 나의 갤러리 페이지
	@RequestMapping(value = "/mygallary")
	public ModelAndView mygallary(HttpSession session,
								  @RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable {

		int page= 1;
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		
		params.put("userNo", String.valueOf(session.getAttribute("sUserNo")));
		params.put("followNo", String.valueOf(session.getAttribute("sUserNo")));
		
		HashMap<String, String> data = iMyGallaryService.authorLikeCnt2(params);
		int cnt = iMyGallaryService.followingCnt(params);
		
		mav.addObject("page", page);
		mav.addObject("data", data);
		mav.addObject("cnt", cnt);
		
		mav.setViewName("JY/mygallary");

		
		return mav;
	}
	
	// 다른사람 갤러리 페이지
	@RequestMapping(value = "/othergallary")
	public ModelAndView othergallary(@RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable {

		int page= 1;
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		params.put("followNo", params.get("authorNo"));

		
		HashMap<String, String> data = iMyGallaryService.authorIsHeart(params);
		
		int cnt = iMyGallaryService.followingCnt(params);
		  
		mav.addObject("cnt", cnt);
		 
		mav.addObject("data", data);
		
		mav.addObject("page", page);
		
		mav.setViewName("JY/othergallary");

		
		return mav;
	}
	
	
	
	
	// 나의 사진갤러리 Ajax
	@RequestMapping(value = "/mypicgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String mypicGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("========================" + params);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getMyPicCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.myPicList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}

	
	// 나의 그림갤러리 Ajax
	@RequestMapping(value = "/mydrawgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String mydrawGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getMyDrawCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.myDrawList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 나의 영상갤러리 Ajax
	@RequestMapping(value = "/myvideogallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String myvideoGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getMyVideoCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.myVideoList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}



	// 다른 사람 사진갤러리 Ajax
	@RequestMapping(value = "/otherpicgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String otherpicGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getOtherPicCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.otherPicList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}

	
	// 다른 사람 그림갤러리 Ajax
	@RequestMapping(value = "/otherdrawgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String otherdrawGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getOtherDrawCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.otherDrawList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}

	// 다른 사람 영상갤러리 Ajax
	@RequestMapping(value = "/othervideogallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String otherVideoGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getOtherVideoCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.otherVideoList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	// 갤러리 페이지
	@RequestMapping(value = "/gallary")
	public ModelAndView gallary(@RequestParam HashMap<String, String> params,
								ModelAndView mav) {
		
		int page= 1;
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		
		mav.addObject("page", page);
		
		mav.setViewName("JY/gallary");

		return mav;
	}
	
	// 사진갤러리 Ajax
	@RequestMapping(value = "/picgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String picGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getPicCnt(params);
		
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.picList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}

	
	// 그림갤러리 Ajax
	@RequestMapping(value = "/drawgallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String drawGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		
		int cnt = iMyGallaryService.getDrawCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.drawList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 영상갤러리 Ajax
	@RequestMapping(value = "/videogallarys",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String videoGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
			ObjectMapper mapper = new ObjectMapper();
			
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int page = Integer.parseInt(params.get("page"));
			
			int cnt = iMyGallaryService.getVideoCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
			
		
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
					
			List<HashMap<String, String>> list = iMyGallaryService.videoList(params);
			
			modelMap.put("list", list);		
			modelMap.put("pb", pb);
			
			return mapper.writeValueAsString(modelMap);
		}

	
	// 메인 페이지
	@RequestMapping(value = "/main")
	public ModelAndView main(ModelAndView mav) {
		mav.setViewName("JY/main");

		return mav;
	}
	
	
	// 글 상세 페이지
	@RequestMapping(value = "/detail")
	public ModelAndView detail(HttpSession session,
								@RequestParam HashMap<String, String> params,
								 ModelAndView mav) throws Throwable {
		
		
		iMyGallaryService.updateViews(params);
		
		HashMap<String, String> data = iMyGallaryService.getPost(params);
		
		if(data.get("TAG_NAME") != null && data.get("TAG_NAME") != "") {
			String str = data.get("TAG_NAME");
	
			String[] array = str.split(",");
			
			for(int i = 0 ; i < array.length ; i++) {
				System.out.println(array[i]);
			}
		
		
			mav.addObject("array", array);
		}
		
		//System.out.println(array);
		
		mav.addObject("data", data);
		
		mav.setViewName("JY/detail");

		return mav;
	}
	
	
	// 글수정 페이지
	@RequestMapping(value = "/edit")
	public ModelAndView edit(HttpSession session,
							@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		

		HashMap<String, String> data = iMyGallaryService.getPost(params);
		
		
		if(data.get("TAG_NAME") != null && data.get("TAG_NAME") != "") {
			String str = data.get("TAG_NAME");
	
			String[] array = str.split(",");
			
			for(int i = 0 ; i < array.length ; i++) {
				System.out.println(array[i]);
			}
		
		
			mav.addObject("array", array);
		}
		
		mav.addObject("data", data);
		
		mav.setViewName("JY/edit");
				
		return mav;	
	}
	
	// 글수정 Ajax
	@RequestMapping(value = "/edits",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String editAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
	
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// mPw의 값을 암호화 후 mPw로 넣겠다.
		//params.put("mPw", Utils.encryptAES128(params.get("mPw")));
		
		
		  try {
			  int cnt = iMyGallaryService.updatePost(params);
			  if(cnt > 0) {
				  modelMap.put("msg", "success");
			  } else {
				  modelMap.put("msg", "failed");
			  }
		  
		  } catch (Throwable e) {
			  e.printStackTrace();
			  modelMap.put("msg", "error");
			  
		  }
		 
	
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	// 글쓰기 페이지
	@RequestMapping(value = "/write")
	public ModelAndView write(HttpSession session, ModelAndView mav) throws Throwable {

		mav.setViewName("JY/write");
		
		return mav;
	}
	
	// 글쓰기 Ajax
	@RequestMapping(value = "/writes",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String writeAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();

		int num = iMyGallaryService.getNum();
		
		params.put("postNo", Integer.toString(num));
		
		System.out.println(params.get("tag"));
		
				
		try {
			int cnt = iMyGallaryService.addPost(params);
			
			System.out.println(params);
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	// 글삭제 Ajax
	@RequestMapping(value = "/postDeletes",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String postDeleteAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
	
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iMyGallaryService.deletePost(params);
			if(cnt > 0) {		
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}
	
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	
	
	
	
	
	// 작품 좋아요 눌렀을 때 Ajax
	@RequestMapping(value = "/postOnHeart",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String postOnHeartAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		try {
			int cnt = iMyGallaryService.postOnHeart(params);
			
			System.out.println("--------------------------------------" + params);
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	
	// 작품 좋아요 취소했을 때 Ajax
	@RequestMapping(value = "/postOffHeart",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String postOffHeartAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		try {
			int cnt = iMyGallaryService.postOffHeart(params);
			
			System.out.println("--------------------------------------" + params);
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	// 작품 좋아요 수 Ajax
	@RequestMapping(value = "/postLikeCnt",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String postLikeCntAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iMyGallaryService.postLikeCnt(params);
				
		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}
	
	// 작품 댓글 수 Ajax
	@RequestMapping(value = "/postCommentCnt",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String postCommentCntAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			HashMap<String, String> data = iMyGallaryService.postCommentCnt(params);
					
			modelMap.put("data", data);

			return mapper.writeValueAsString(modelMap);
		}
	
	
	
	
	// 작가 좋아요 눌렀을 때 Ajax
	@RequestMapping(value = "/authorOnHeart",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String authorOnHeartAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		try {
			int cnt = iMyGallaryService.authorOnHeart(params);
			
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	
	// 작가 좋아요 취소했을 때 Ajax
	@RequestMapping(value = "/authorOffHeart",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String authorOffHeartAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		try {
			int cnt = iMyGallaryService.authorOffHeart(params);
			
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}

	
	// 작가 좋아요 수 Ajax
	@RequestMapping(value = "/authorLikeCnt",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String authorLikeCntAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iMyGallaryService.authorLikeCnt(params);
		

		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}
	
	
	// 댓글 쓰기 Ajax
	@RequestMapping(value = "/commentWrite",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String commentWriteAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		try {
			int cnt = iMyGallaryService.addComment(params);
			
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	// 댓글리스트 Ajax
	@RequestMapping(value = "/commentList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String commentListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page2"));
		
		int cnt = iMyGallaryService.getCommentCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.commentList(params);
		
		modelMap.put("list", list);		
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	// 답글리스트 Ajax
	@RequestMapping(value = "/replyCommentList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String replyCommentListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		/* int page = Integer.parseInt(params.get("page")); */
		
		/*
		 * int cnt = iMyGallaryService.getCommentCnt(params);
		 * 
		 * PagingBean pb = iPagingService.getPagingBean(page, cnt, 10, 5);
		 * 
		 * params.put("startCnt", Integer.toString(pb.getStartCount()));
		 * params.put("endCnt", Integer.toString(pb.getEndCount()));
		 */
				
		List<HashMap<String, String>> list = iMyGallaryService.replyCommentList(params);
		
		modelMap.put("list", list);		
		/* modelMap.put("pb", pb); */
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	// 답글 쓰기 Ajax
	@RequestMapping(value = "/replyCommentWrite",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String replyCommentWriteAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println(params);
				
		try {
			int cnt = iMyGallaryService.addReplyComment(params);
			
			if (cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}

		return mapper.writeValueAsString(modelMap);
	}
	
	// 댓글삭제 Ajax
	@RequestMapping(value = "/deleteComment",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteCommentAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
	
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iMyGallaryService.deleteComment(params);
			if(cnt > 0) {		
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}
	
		return mapper.writeValueAsString(modelMap);
	}
	
	// 답글삭제 Ajax
	@RequestMapping(value = "/deleteReplyComment",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteReplyCommentAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
	
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iMyGallaryService.deleteReplyComment(params);
			if(cnt > 0) {		
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}
	
		return mapper.writeValueAsString(modelMap);
	}
	
	// 메인갤러리 Ajax
	@RequestMapping(value = "/mainList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String mainListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
				
		List<HashMap<String, String>> list1 = iMyGallaryService.mainPicList(params);
		List<HashMap<String, String>> list2 = iMyGallaryService.mainDrawList(params);
		List<HashMap<String, String>> list3 = iMyGallaryService.mainVideoList(params);
		
		modelMap.put("list1", list1);	
		modelMap.put("list2", list2);	
		modelMap.put("list3", list3);	
		
		return mapper.writeValueAsString(modelMap);
	}
	

	
	// 통계관리 페이지
	@RequestMapping(value = "/chart")
	public ModelAndView NewFile(ModelAndView mav) {

		mav.setViewName("JY/chart");

		
		return mav;
	}
	
	// 통계관리 Ajax
	@RequestMapping(value = "/getChartData", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getChartDataAjax(@RequestParam HashMap<String, String> params,
								ModelAndView modelAndView) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
	
		
		List<HashMap<String, Object>> list = iMyGallaryService.chart(params);
		
		System.out.println(">>>>>>>>" + params);
		System.out.println(">>>>>>>>>>>>>>>>" + list);
		
		modelMap.put("list", list);
		
        return mapper.writeValueAsString(modelMap);
	}
	
	// 팔로우, 팔로워 팝업
	@RequestMapping(value = "/followPopup")
	public ModelAndView followPopup(ModelAndView mav) {
		mav.setViewName("JY/followPopup");

		return mav;
	}
	
	// 팔로워 Ajax
	@RequestMapping(value = "/followerList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String followerListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("followpage"));
		
		int cnt = iMyGallaryService.followerCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 11, 1);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.followerList(params);
		
		modelMap.put("list", list);		
		modelMap.put("cnt", cnt);		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 팔로잉 Ajax
	@RequestMapping(value = "/followingList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String followingListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("followpage"));
		
		int cnt = iMyGallaryService.followingCnt(params);
		System.out.println("++++++++++++++++++++++" + cnt);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 11, 1);
		
	
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
				
		List<HashMap<String, String>> list = iMyGallaryService.followingList(params);
		
		modelMap.put("list", list);
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	// 신고하기
	@RequestMapping(value="/userReport",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String userReportAjax(HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		try {
			HashMap<String, String> data = iMyGallaryService.getPost(params);	
			
			modelMap.put("data", data);
			modelMap.put("userNo", String.valueOf(session.getAttribute("sUserNo")));
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}	
		
		return mapper.writeValueAsString(modelMap);
	
	}

	// 신고하기 전송
	@RequestMapping(value="/userReports",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String userReportsAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			int cnt = iMyGallaryService.addReport(params);
			
			
			if(cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}	
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	// 댓글 신고하기
	@RequestMapping(value="/commentReport",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String commentReportAjax(HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		
		try {
			HashMap<String, String> data = iMyGallaryService.getComment(params);	
			
			modelMap.put("data", data);
			modelMap.put("userNo", String.valueOf(session.getAttribute("sUserNo")));
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}	
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	// 댓글 신고하기 전송
	@RequestMapping(value="/userCommentReports",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String userCommentReportsAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			int cnt = iMyGallaryService.addCReport(params);
			
			
			if(cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
			}
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}	
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	
	
	
}
