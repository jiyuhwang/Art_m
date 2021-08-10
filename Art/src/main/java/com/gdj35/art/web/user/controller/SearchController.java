package com.gdj35.art.web.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gdj35.art.web.user.service.ISearchService;

@Controller
public class SearchController {
	
	@Autowired
	public IPagingService iPagingService;
	
	@Autowired
	public ISearchService iSearchService;
	
	
	
	
	@RequestMapping(value="/searchPage")
	public ModelAndView searchPage(ModelAndView mav) {
		
		mav.setViewName("h/searchPage");
		return mav;
	}
	
	
	
	//------------------------------------------------검색페이지
	
		@RequestMapping(value="/searchGallaryPage")
		public ModelAndView searchGallaryPage(
				@RequestParam HashMap<String, String> params,
				ModelAndView mav) throws Throwable {
			
			//페이징처리
			int page = 1;
					
			if(params.get("page") != null) {
				page = Integer.parseInt(params.get("page"));
			}
			
			mav.addObject("page", page);
			mav.setViewName("h/searchGallaryPage");
			return mav;
		}
		
		// 사진검색 ajax
		@RequestMapping(value = "/picSearch",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String picSearchAjax(
				@RequestParam HashMap<String, String> params) throws Throwable {
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int page = Integer.parseInt(params.get("page"));
				
			int cnt = iSearchService.getSCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
					
			List<HashMap<String, String>> list = iSearchService.getSearchList(params);
			System.out.println("***********사진cnt: " + cnt);
			System.out.println("***********사진list: " + list);
			System.out.println("***********사진파람: " + params);
			
			modelMap.put("cnt", cnt);
			modelMap.put("list", list);
			modelMap.put("pb", pb);

			return mapper.writeValueAsString(modelMap);
		
		}
		
		// 그림검색 ajax
		@RequestMapping(value = "/drawSearch",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String drawSearchAjax(
				@RequestParam HashMap<String, String> params) throws Throwable {
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int page = Integer.parseInt(params.get("page"));
			
			int cnt = iSearchService.getSCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
			System.out.println("***********그림파람: " + params);
		
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
					
			List<HashMap<String, String>> list = iSearchService.getSearchList(params);
			
			modelMap.put("cnt", cnt);
			modelMap.put("list", list);
			modelMap.put("pb", pb);

			return mapper.writeValueAsString(modelMap);
		
		}
		
		// 영상검색 ajax
		@RequestMapping(value = "/videoSearch",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String videoSearchAjax(
				@RequestParam HashMap<String, String> params) throws Throwable {
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int page = Integer.parseInt(params.get("page"));
			
			int cnt = iSearchService.getSCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
			System.out.println("***********동영상파람: " + params);
		
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
					
			List<HashMap<String, String>> list = iSearchService.getSearchList(params);
			
			modelMap.put("cnt", cnt);
			modelMap.put("list", list);
			modelMap.put("pb", pb);

			return mapper.writeValueAsString(modelMap);
		
		}
		
		// 작가검색 ajax
		@RequestMapping(value = "/writerSearch",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String writerSearchAjax(
				@RequestParam HashMap<String, String> params) throws Throwable {
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int page = Integer.parseInt(params.get("page"));
			int cnt = iSearchService.getWCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 12, 5);
			
			System.out.println("***********작가파람: " + params);
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));

			List<HashMap<String, String>> list = iSearchService.getWriterList(params);
			
			modelMap.put("cnt", cnt);
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			return mapper.writeValueAsString(modelMap);
		
		}

}
