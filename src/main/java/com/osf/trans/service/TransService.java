package com.osf.trans.service;

import java.util.List;

import com.osf.trans.vo.TransVO;


public interface TransService {
	public Object insertTrans(TransVO trans);
	public Object findTrans(TransVO trans);
	public List<TransVO> getTransList();
}
