package com.osf.trans.mapper;

import java.util.List;

import com.osf.trans.vo.CodeVO;

public interface CodeMapper {
	public List<CodeVO> getCodeList();
	public CodeVO getCodeByCode(Integer codeNum);
}
