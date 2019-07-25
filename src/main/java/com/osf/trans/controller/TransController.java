package com.osf.trans.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.osf.trans.service.CodeService;
import com.osf.trans.service.TransService;
import com.osf.trans.vo.TransVO;

@Controller
public class TransController {

	@Resource
	private CodeService cs;
	@Resource
	private TransService ts;
	
	@GetMapping("/trans")
	public String goToTrans(Model m){
		m.addAttribute("codes",cs.getCodeList());
		m.addAttribute("trans",ts.getTrans());
//		List<TransVO> tList = ts.getTrans();
//		for(int i=0;i<tList.size();i++) {
//			m.addAttribute("transList",ts.getTrans());			
//		}
//		System.out.println(ts.getTrans());
		return "trans";
	}
	
	@PostMapping(value="/trans",produces = "application/text; charset=utf8")
	public @ResponseBody Object translation(TransVO trans) {
		Object getDbResult = ts.findTrans(trans);
		if(getDbResult!=null) {
			System.out.println(getDbResult);
			return getDbResult;
		}
		return ts.insertTrans(trans);
	}
	
	@GetMapping("/rank")
	public @ResponseBody List<TransVO> getTransList(){
		return ts.getTransList();
	}
	
}
