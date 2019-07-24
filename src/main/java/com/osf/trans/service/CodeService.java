package com.osf.trans.service;

import java.util.List;

import com.osf.trans.vo.CodeVO;


public interface CodeService {
	public List<CodeVO> getCodeList();
	public String getCodeByCode(Integer codeNum);
}
