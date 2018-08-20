package com.hshbic.ai.dubbo.common;

import java.util.Map;

/**
 * 本地dubbo公共通讯接口
 */
public interface LocalCommonService {
	
	public Map<String,Object> getService(Map<String,Object> params);
	
}
