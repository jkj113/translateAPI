package com.osf.trans.mapper;

import java.util.List;

import com.osf.trans.vo.TransVO;


public interface TransMapper {
	public Integer insertTrans(TransVO trans);
	public TransVO findTrans(TransVO trans);
	public Integer plusCount(Integer transNum);
	public List<TransVO> getTransList();
	public List<TransVO> getTrans();
}
