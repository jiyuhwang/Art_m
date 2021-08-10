package com.gdj35.art.web.user.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj35.art.common.bean.PagingBean;
import com.gdj35.art.common.service.IPagingService;
import com.gdj35.art.web.user.service.IManagerService;


@Controller
public class ManagerController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	public IPagingService iPagingService;
	
	@Autowired
	public IManagerService iManagerService;
	
	@RequestMapping(value = "/sendMail",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String sendMailAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println("넘어 오는지 보자" + params);
		
		 	String subject = params.get("title"); //보낼 제목을 넣을 수 있습니다.
	        String content = params.get("ctt"); // 내용 입력이 가능합니다.
	        String fileName = params.get("file");
	        
	        
	        String from = "artproject21@naver.com"; // 보낼 메일을 작성할 수 있습니다.
	     
	        
	        
	        String mailList	= params.get("emailAdd");
	        String[] to	= mailList.split(",");
	        // 받는 사람의 메일을 to라는 부분에 저장할 수 있는데 여러 명에게 보내려면
	        // 배열에 각 메일을 담아서 아래 setTo에 입력해주면 됩니다.
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8"); // true는 멀티파트 메세지를 사용하겠다는 의미입니다.
			
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			
			// 파일을 첨부하는 것
			FileSystemResource file = new FileSystemResource(new File("C:\\MyWork\\workSpace_JHD\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Art\\resources\\upload\\" + params.get("file")));
			mailHelper.addAttachment("\"" + params.get("file") + "\"" , file);
			
			mailSender.send(mail);
			
			modelMap.put("msg", "success");
			
			return mapper.writeValueAsString(modelMap);
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value="/writingManager")
	public ModelAndView writinerManager(ModelAndView mav) {
		
		mav.setViewName("HD/writingManager");
		return mav;
	}
	
	@RequestMapping(value="/editManager")
	public ModelAndView editManager(ModelAndView mav,@RequestParam HashMap<String,String> params) throws Throwable {
		
		System.out.println(params);
		
		HashMap<String,String> row = iManagerService.getNotice(params);
		
		System.out.println(row);
		
		mav.addObject("oneRow", row);
		System.out.println(row);
		
		mav.setViewName("HD/editManager");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/editManager") public ModelAndView
	 * editManager(ModelAndView mav,@RequestParam HashMap<String,String> params)
	 * throws Throwable {
	 * 
	 * System.out.println(params);
	 * 
	 * HashMap<String,String> row = iManagerService.getNotice(params);
	 * 
	 * System.out.println(row);
	 * 
	 * mav.addObject("oneRow", row);
	 * 
	 * mav.setViewName("HD/editManager"); return mav; }
	 */
	
	@RequestMapping(value="/addGong")
	public ModelAndView addGong(HttpSession session, ModelAndView mav,@RequestParam HashMap<String,String> params) throws Throwable {
		
		System.out.println("this is addGong"+params);
		
		mav.setViewName("HD/addGong");
		return mav;
	}
	

	// 공지사항 페이지
	@RequestMapping(value = "/gongji")
	public ModelAndView gongji(ModelAndView mav,@RequestParam HashMap<String,String> params) throws Throwable {

		
		mav.setViewName("/HD/gongji");
		return mav;
	}
	
	@RequestMapping(value = "/gongji_page",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String gongji_pageAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		
		
		if(params.get("sortO") != null &&  params.get("sortO") != "") {
			
		}else {
			params.put("sortO","1");
		}
		System.out.println("넘어 오는지 보자" + params);
		
		try {
			int page =1;
			
			if(params.get("page") != null) {
				page = Integer.parseInt(params.get("page"));
			}
			
			int cnt = iManagerService.getGongCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 7, 10);
			
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			
			
			List<HashMap<String,String>> list = iManagerService.getGList(params);
			System.out.println(list);
			
			
			modelMap.put("pb", pb);
			modelMap.put("list", list);
			modelMap.put("cnt", cnt);
			/* modelMap.put("user", user); */
		}catch(Throwable e) {
			e.printStackTrace();
		}
			
			
			return mapper.writeValueAsString(modelMap);
		
	}
	
	@RequestMapping(value = "/mailList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String mailListAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println("넘어 오는지 보자" + params);
		
		if(params.get("userNo") == null || params.get("userNo") == "") {
			System.out.println("아무것도 안찍혔다.");
		}else {
			List<HashMap<String,String>> list = iManagerService.getMailUser(params);
			
			System.out.println(list);
			
			modelMap.put("list", list);
			
		}
		
		
		
		
		return mapper.writeValueAsString(modelMap);
		
	}


	@RequestMapping(value="/user_detail(memo)")
	public ModelAndView user_detailM(ModelAndView mav) {
		
		mav.setViewName("HD/user_detail(memo)");
		return mav;
	}
	
	@RequestMapping(value="/user_detail(post)")
	public ModelAndView user_detailP(ModelAndView mav) {
		
		mav.setViewName("HD/user_detail(post)");
		return mav;
	}
	
	
	
	@RequestMapping(value="/user_board")
	public ModelAndView user_board(HttpSession session,ModelAndView mav,
									@RequestParam HashMap<String,String> params) throws Throwable {
		System.out.println("---------------");
		System.out.println(params);
		System.out.println("---------------");
		
		
		int page=1;
		
		
		 if(params.get("page") != null) { 
			 page= Integer.parseInt(params.get("page"));
		  }
		 
		//Total count를 가져온다 T
		int cnt = iManagerService.getTCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
		
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		
		
		
		//Main list를 가져온다. 그래서 M으로 지정
		List<HashMap<String,String>> list = 
					iManagerService.getMList(params);
		
		/*
		 * HashMap<String,String> user =iManagerService.getUser(params);
		 */
		
		System.out.println(list);
		System.out.println(params);
		/* mav.addObject("user", user); */
		mav.addObject("cnt", cnt);
		mav.addObject("pb", pb);
		mav.addObject("page", page);
		mav.addObject("list", list);
		mav.addObject("now", "member");
		mav.setViewName("HD/user_board");
		return mav;
	}
	
	
	
	
	@RequestMapping(value = "/user_datailP",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String user_datailPAjax(HttpSession session,@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println(params);
		
		// 목록취득
		HashMap<String,String> user=iManagerService.getUser(params);
		//detail post의 작품 리스트를 가져오는 메서드
		List<HashMap<String,String>> list = iManagerService.getDPList(params);
		//메모 목록 취득
		List<HashMap<String,String>> listM = iManagerService.getDMList(params); 

		System.out.println("this is parmas >>>>"+params);
		
		/*
		 * PagingBean pb = iPagingService.getPagingBean(page, maxCount, viewCnt,
		 * pageCnt)
		 */
		 
		System.out.println("USER >>>"+user);
		System.out.println("LIST >>>"+list);
		System.out.println("LISTM >>>"+listM);
		/* modelMap.put("pb",pb); */
		
		modelMap.put("listM", listM);
		modelMap.put("list", list);
		modelMap.put("user", user);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	@RequestMapping(value = "/delOneRow",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String delOneRowAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		String arr = params.get("userNo");
		String [] usersNo = arr.split(",");
		int cnt = 0;
		System.out.println(Arrays.toString(usersNo));
		
		for(int i =0 ; i <usersNo.length; i++) {
			params.put("userNo",usersNo[i]);
			System.out.println(">>>>>>이거는 포문 안에 파람 값" + params);
			cnt += iManagerService.deleteOneRow(params);
			params.remove("userNo");
		}
		
		System.out.println(params);
		System.out.println(cnt);
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/out_user_list",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String out_user_listAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println(params);
		
		int page=1;
		
		 if(params.get("page") != null) { 
			 page= Integer.parseInt(params.get("page"));
		  }
		 
		//Total count를 가져온다 T
		int cnt = iManagerService.getOutCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
		
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		
		List<HashMap<String,String>> list = iManagerService.outUserList(params);
		
		System.out.println(list);
		System.out.println(pb);
		
		modelMap.put("pb", pb);
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/user_update",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String user_updateAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println("고객 업데이트를 위한 파람 값 >>> "+params);
		
		try {
			 int cnt = iManagerService.updateUser(params); 
			
			 System.out.println("고객을 업데이트했는지 안했는지 >> " + cnt); 
			
			 if(cnt >0 ) { 
				 modelMap.put("msg","success"); 
			 }	 
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("msg","error");
		}
		

//		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/add_memo",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String add_memoAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println("메모 등록을 위한 폼 >>> "+params);
		
		try {
			
			
			int cnt = iManagerService.addMemoHD(params); 
			
			
			List<HashMap<String,String>> list = iManagerService.getDMList(params);
			
			
			System.out.println("고객을 업데이트했는지 안했는지 >> " + cnt); 
			
			if(cnt >0 ) { 
				modelMap.put("msg","success"); 
				modelMap.put("list",list); 
			}	 
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("msg","error");
		}
		
		
//		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getMemoList",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getMemoListAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		System.out.println("------------------------");
		System.out.println("메모 검색 가능하니? >>> " + params);
		System.out.println("------------------------");
		
		try {
			
		List<HashMap<String,String>> list = iManagerService.getDMList(params);
	
		modelMap.put("list",list); 
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("msg","error");
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value="/gong_board")
	public ModelAndView gong_board(ModelAndView mav,
					@RequestParam HashMap<String,String> params) throws Throwable {
		
		
		mav.addObject("now", "gong");
		mav.setViewName("HD/gong_board");
		return mav;
	}
	
	@RequestMapping(value="/gong_detail")
	public ModelAndView gong_detail(ModelAndView mav,
			@RequestParam HashMap<String,String> params) throws Throwable {
		
		
		
		System.out.println("공지사항 페이지"+params);
		
		
		HashMap<String,String> data =iManagerService.getNotice(params);
		
		
		mav.addObject("data", data);
		mav.addObject("now", "gong");
		mav.setViewName("HD/gong_detail");
		return mav;
	}
	
	@RequestMapping(value = "/gong_boardA",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String gong_boardAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println(params);
		
		int page =1;
		
		
		try {
			if(params.get("page") != null && params.get("page") != "") { page = Integer.parseInt(params.get("page"));
			}
		}catch(Throwable e){
			e.printStackTrace();
		}
		 
		//총 몇개의 공지사항이 있는지 표시해주기위해 개수를 카운트해서 가져온다.
		int cnt = iManagerService.getGongCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
		
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("sortO","1");
		
		
		System.out.println("-------------------------------");
		System.out.println(pb.getEndPcount());
		System.out.println(pb.getStartPcount());
		System.out.println("-------------------------------");
		
		//공지사항 게시판을 만들기 위해 값을 가져온다.
		 List<HashMap<String,String>> list = iManagerService.getGList(params);
		 System.out.println("list를 찍어보자 "+list);
		 
		 System.out.println(list);
		
		modelMap.put("page", page);
		modelMap.put("cnt", cnt);
		modelMap.put("pb", pb);
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value = "/gongRowsDel",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String rowsDelAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println(params);
		
		
		int cnt = iManagerService.gongRowsDel(params);
		
		System.out.println(cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	@RequestMapping(value = "/addGongs",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String addGongAjax(HttpSession session,@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		// httpSession 값 받아오기 그래야 관리자 번호 지정가능
		// 로그인 구현하기
		System.out.println(params);
		Map<String, Object> modelMap = new HashMap<String,Object>();
		System.out.println(session.getAttribute("sAdminNo"));
		try {
			params.put("adminNo",String.valueOf(session.getAttribute("sAdminNo")));
			
			 System.out.println("this is parmas from addGong" + params);
			
			 int cnt = iManagerService.addGong(params);
			 
			 if(cnt>0) {
				 modelMap.put("msg", "success");
			 }else {
				 modelMap.put("msg", "failed");
			 }
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/editManagerUpdates",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String editManagerUpdateAjax(HttpSession session,@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		// httpSession 값 받아오기 그래야 관리자 번호 지정가능
		// 로그인 구현하기
		Map<String, Object> modelMap = new HashMap<String,Object>();
		System.out.println(session.getAttribute("sUserNo"));
		try {
			params.put("adminNo",String.valueOf(session.getAttribute("sUserNo")));
			
			System.out.println("this is parmas from updateGong" + params);
			
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		int cnt = iManagerService.updateGong(params);
		
		if(cnt>0) {
			modelMap.put("msg", "success");
		}else {
			modelMap.put("msg", "failed");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value="/tag_board")
	public ModelAndView tag_board(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		
		
		List<HashMap<String, String>> tList = iManagerService.getTList(params);
		
		int cnt = iManagerService.getTagCnt(params);
		
		
		
		mav.addObject("cnt", cnt);
		mav.addObject("tList", tList);
		mav.addObject("now", "tag");
		mav.setViewName("HD/tag_board");
		
		return mav;
	}
	
	@RequestMapping(value="/addTag")
	public ModelAndView addTag(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		

		int cnt = iManagerService.addTag(params);
		
		if(cnt>0) {
			mav.addObject("msg", "success");
		}else {
			mav.addObject("msg", "failed");
		}
		
		
		mav.addObject("now", "tag");
		
		mav.setViewName("redirect:/tag_board");
		
		
		return mav;
	}
	
	@RequestMapping(value="/delTag")
	public ModelAndView delTag(ModelAndView mav, @RequestParam HashMap<String, String> params) throws Throwable {
		
		
		/*
		 * String[] arr = {params.get("tagNo")};
		 * System.out.println(Arrays.toString(arr));
		 */
		
		int cnt = iManagerService.delTag(params); 
		
		if(cnt>0) {
			mav.addObject("msg", "success");
		}else {
			mav.addObject("msg", "failed");
		}
		
		
		mav.addObject("now", "tag");
		
		mav.setViewName("redirect:/tag_board");
		
		
		return mav;
	}
	
	
	@RequestMapping(value = "/updateMemo",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String updateMemoAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		System.out.println("----------------");	
		System.out.println(params);
		System.out.println("----------------");	
		
		
		int cnt = iManagerService.updateMemo(params);
		
		List<HashMap<String, String>> list = iManagerService.getDMList(params);
		System.out.println(cnt);
		System.out.println(list);
		modelMap.put("list", list);
		modelMap.put("msg", "success");
			
	
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	
	
	
	
	
	
	//----------------------------------------------현
	//작품관리
	@RequestMapping(value="/gallaryManage")
	public ModelAndView gallaryManage(ModelAndView mav) throws Throwable {
		
		mav.setViewName("h/gallaryManage");
		return mav;
	}
	

	//리스트 불러오기
	@RequestMapping(value="/entireList",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
		public String entireListAjax(
		@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//페이징처리
		int page = 1;
		
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
							
		try {
			int cnt = iManagerService.getGallaryMCnt(params);
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
			
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			params.put("startCnt", Integer.toString(pb.getStartCount()));
				
			
			//목록취득
			List<HashMap<String, String>> list = iManagerService.getPostList(params);
			
			System.out.println(params);
			System.out.println(list);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("cnt", cnt);
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	
	//작품관리 상세페이지 보기
	@RequestMapping(value="/drawUserPopup",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String drawUserPopupAjax(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//페이징처리
		int page = Integer.parseInt(params.get("page"));
		
		try {
			int cnt = iManagerService.getGallaryMCnt(params);
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
			
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			params.put("startCnt", Integer.toString(pb.getStartCount()));
					
			
			//데이터취득
			HashMap<String, String> data = iManagerService.getUserDetail(params);
		
			modelMap.put("data", data);
			modelMap.put("pb", pb);
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}		
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	//업데이트하고 새로고침
	@RequestMapping(value="/drawEdits",
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String drawEditsAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
	
	try {
		int cnt = iManagerService.updatePostDetail(params);
		
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
	
	//삭제하기
	@RequestMapping(value = "/deleteGallary",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteGallaryAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		String checkArr = params.get("checkedArr");
		String [] postArry = checkArr.split(",");
		
		int cnt = 0;
		
		try {
		
			for(int i =0 ; i <postArry.length; i++) {
			params.put("postNo", postArry[i]);
			cnt += iManagerService.deleteG(params);
			params.remove("postNo");
		}
		
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
	
	//복원하기
	@RequestMapping(value = "/returnDel",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String returnDelAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		String checkArr = params.get("checkedArr");
		String [] postArry = checkArr.split(",");
		
		int cnt = 0;
		
		try {
		
			for(int i =0 ; i <postArry.length; i++) {
			params.put("postNo", postArry[i]);
			cnt += iManagerService.returnG(params);
			params.remove("postNo");
		}
		
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
	
	
	
	
	
	//신고관리 페이지
	@RequestMapping(value="/reportManage")
	public ModelAndView reportManage(ModelAndView mav) {
		
		mav.setViewName("h/reportManage");
		return mav;
	}
	
	//신고 리스트 보기
	@RequestMapping(value="/reportList",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
		public String reportListAjax(
		@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//페이징처리
		int page = 1;
				
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		
		try {
							
			int cnt = iManagerService.getReportMCnt(params);
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
			
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			params.put("startCnt", Integer.toString(pb.getStartCount()));
					
			
			//목록취득
			List<HashMap<String, String>> list = iManagerService.getReportList(params);
					
			System.out.println(params);
			System.out.println(list);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("cnt", cnt);			
				
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
	
	//삭제하기
	@RequestMapping(value = "/deleteReport",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteReportAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		String checkArr = params.get("checkedArr");
		String [] postArry = checkArr.split(",");
		
		int cnt = 0;
		
		try {
		
			for(int i =0 ; i <postArry.length; i++) {
			params.put("rNo", postArry[i]);
			cnt += iManagerService.deleteR(params);
			params.remove("rNo");
		}
		
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
	
	//복원하기
	@RequestMapping(value = "/returnDelr",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String returnDelrAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String,Object>();
		
		String checkArr = params.get("checkedArr");
		String [] postArry = checkArr.split(",");
		
		int cnt = 0;
		
		try {
		
			for(int i =0 ; i <postArry.length; i++) {
			params.put("rNo", postArry[i]);
			cnt += iManagerService.returnR(params);
			params.remove("rNo");
		}
		
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
	
	
	//신고내용보기
	@RequestMapping(value="/drawReportPopup",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String drawReportPopupAjax(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//페이징처리
		int page = Integer.parseInt(params.get("page"));
		
		try {
			int cnt = iManagerService.getReportMCnt(params);
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 10);
			
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			params.put("startCnt", Integer.toString(pb.getStartCount()));
					
			
			//데이터취득
			HashMap<String, String> data = iManagerService.getReportDetail(params);
			
			//메모 목록 취득
			List<HashMap<String, String>> list = iManagerService.getReportMemo(params);
			System.out.println("---------------이거받아야함신고내용보기"+ params);
			
			
			modelMap.put("list", list);
			modelMap.put("data", data);
			modelMap.put("pb", pb);
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}		
		
		return mapper.writeValueAsString(modelMap);
	
	}
	
	//신고메모...!
	@RequestMapping(value="/reportMemo",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String reportMemoAjax(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		System.out.println("이건 신고ㅁ메모....!!" +params);
		try {
			//데이터취득
			HashMap<String, String> memo = iManagerService.getMemoDetail(params);
			
			modelMap.put("memo", memo);
			modelMap.put("msg", "success");
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}		
		
		return mapper.writeValueAsString(modelMap);
	
	}
	

	
	
	//메모 수정하고 나서~
	@RequestMapping(value="/saveReportMemo",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String saveReportMemoAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		System.out.println("이거받아야함"+ params);
		try {
			int cnt = iManagerService.updateReportMemo(params);
			List<HashMap<String, String>> list = iManagerService.getReportMemo(params);
			System.out.println("---------------이거받아야함수정하고나서"+ params);
			
			if(cnt > 0) {
				modelMap.put("list", list);
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
	
	//메모 삭제
	@RequestMapping(value="/delReportMemo",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String delReportMemoAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		

		
		try {
			
			int cnt = iManagerService.deleteReportMemo(params);
			List<HashMap<String,String>> list = iManagerService.getDMList(params);
			
			if(cnt > 0) {
				modelMap.put("list", list);
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
	
	//메모 추가하기
	@RequestMapping(value="/addMemo",
				method=RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String addMemoAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		System.out.println("이거받아야함 아예 add메모로 안온다????????????"+ params);
		
		try {
			int cnt = iManagerService.addMemo(params);
			
			System.out.println("이거받아야함2"+ cnt);
			System.out.println("이거받아야함3"+ params);
			
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
	
	//셀렉트 수정하고 나서
	@RequestMapping(value="/changeSelect",
			method=RequestMethod.POST,
			produces="text/json;charset=UTF-8")
	@ResponseBody
	public String changeSelectAjax(
			@RequestParam HashMap<String, String> params) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iManagerService.updateReport(params);
			HashMap<String, String> data = iManagerService.getReportDetail(params);
			
			if(cnt > 0) {
				
				modelMap.put("data", data);
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
