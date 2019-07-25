package com.osf.trans.vo;

import lombok.Data;

@Data
public class TransVO {
	private Integer transNum;
	private String transText;
	private String transResult;
	private Integer transCount;
	private Integer transSource;
	private Integer transTarget;
	private String transError;
	private String sourceLang;
	private String targetLang;
}
