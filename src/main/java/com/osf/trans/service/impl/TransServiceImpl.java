package com.osf.trans.service.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.osf.trans.mapper.TransMapper;
import com.osf.trans.service.CodeService;
import com.osf.trans.service.TransService;
import com.osf.trans.vo.TransVO;

@Service
public class TransServiceImpl implements TransService {

	@Resource
	private TransMapper tm;
	@Resource
	private CodeService cs;
	
	@Override
	public Object insertTrans(TransVO trans) {
		String clientId = "dXW3zTfKEESoMLS3r5T1";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "c3SB4MVU7F";//애플리케이션 클라이언트 시크릿값";
        String source = cs.getCodeByCode(trans.getTransSource()).trim();
        String target = cs.getCodeByCode(trans.getTransTarget()).trim();
        try {
        	String text = URLEncoder.encode(trans.getTransText(),"UTF-8");
            String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            // post request
            String postParams = "source="+source+"&target="+target+"&text=" + text;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            ObjectMapper om = new ObjectMapper();
            Map<String,Object> rMap = om.readValue(response.toString(), Map.class);
            String transResult = ((Map)((Map)rMap.get("message")).get("result")).get("translatedText").toString();
            if(rMap.get("errorCode")!=null) {
            	trans.setTransResult("에러");
            	trans.setTransError((String)rMap.get("errorCode"));
            	return tm.insertTrans(trans);
            }else {
            	trans.setTransResult(transResult);
            	tm.insertTrans(trans);
            	return transResult;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
	        return null;
	}

	@Override
	public Object findTrans(TransVO trans) {
		TransVO result = tm.findTrans(trans);
		if(result!=null) {
			tm.plusCount(result.getTransNum());
			return result.getTransResult();
		}
		return null;
	}

	@Override
	public List<TransVO> getTransList() {
		return tm.getTransList();
	}
}
