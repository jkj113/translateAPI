package com.osf.trans.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.osf.trans.mapper.CodeMapper;
import com.osf.trans.service.CodeService;
import com.osf.trans.vo.CodeVO;

@Service
public class CodeServiceImpl implements CodeService {

	@Resource
	private CodeMapper cm;
	
	@Override
	public List<CodeVO> getCodeList() {
		return cm.getCodeList();
	}

	@Override
	public String getCodeByCode(Integer codeNum) {
		CodeVO cvo = cm.getCodeByCode(codeNum);
		return cvo.getCodeCode();
	}

}
