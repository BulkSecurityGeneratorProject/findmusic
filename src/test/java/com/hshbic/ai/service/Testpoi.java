package com.hshbic.ai.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.collections.ExtendedProperties;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.hshbic.ai.service.dto.MusicDTO;

public class Testpoi {

    public static void main(String[] args) throws IOException {
        Workbook wb =null;
        Sheet sheet = null;
        Row row = null;
        List<MusicDTO> musiclist = new ArrayList<MusicDTO>();
        String filePath = "D:\\working\\projects\\findmusic\\自建音乐库10w.xlsx";
        wb = readExcel(filePath);
        if(wb != null){
            //获取第一个sheet
            sheet = wb.getSheetAt(0);
            //获取最大行数
            int rownum = sheet.getPhysicalNumberOfRows();
            //获取第一行
            row = sheet.getRow(0);
            //获取最大列数
            int colnum = row.getPhysicalNumberOfCells();
            for (int i = 1; i<rownum; i++) {
                row = sheet.getRow(i);
                if(row !=null){
                	  MusicDTO music = new MusicDTO();
                	  music.setId(Math.round(Double.parseDouble(val(row.getCell(0)))));
                	  music.setArea(val(row.getCell(1)));
                	  music.setCate(val(row.getCell(2)));
                	  String score = val(row.getCell(3));
                	  music.setScore(StringUtils.isEmpty(score)?0:Double.parseDouble(score));
                	  music.setSinger(val(row.getCell(4)));
                	  music.setSingerAlia1(val(row.getCell(5)));
                	  music.setSingerAlia2(val(row.getCell(6)));
                	  music.setSong(val(row.getCell(7)));
                	  music.setSongAlia1(val(row.getCell(8)));
                	  music.setSongAlia2(val(row.getCell(9)));
                	  music.setVersion(val(row.getCell(10)));
                	  music.setExtra(val(row.getCell(11)));
                	  musiclist.add(music);
                }else{
                    break;
                }
            }
        }
        
      /*  
       * curl -s -XPOST localhost:9200/_bulk --data-binary "@requests"
          批量导入数据到es的格式要求
       action_and_meta_data\n
        optional_source\n
        action_and_meta_data\n
        optional_source\n
        ....
        action_and_meta_data\n
        optional_source\n
        */
        //action_and_meta_data
        //{"index":{"_index":"stuff_orders","_type":"order_list","_id":903713}}
        StringBuilder sb = new StringBuilder();
        for(MusicDTO music:musiclist) {
        	sb.append("{\"index\":{\"_index\":\"xiaou_music\",\"_type\":\"music_list\",\"_id\":"+music.getId()+"}}"+"\r\n");
        	sb.append(JSONObject.toJSONString(music)+"\r\n");
        }
        Files.write(Paths.get("D:\\working\\projects\\findmusic\\10w_music.json"), sb.toString().getBytes());  

    }
    //读取excel
    public static Workbook readExcel(String filePath){
        Workbook wb = null;
        if(filePath==null){
            return null;
        }
        String extString = filePath.substring(filePath.lastIndexOf("."));
        InputStream is = null;
        try {
            is = new FileInputStream(filePath);
            if(".xls".equals(extString)){
                return wb = new HSSFWorkbook(is);
            }else if(".xlsx".equals(extString)){
                return wb = new XSSFWorkbook(is);
            }
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return wb;
    }
    public static String val(Cell cell){
    	String cellValue = null;
        if(cell!=null){
            //判断cell类型
            switch(cell.getCellType()){
	            case Cell.CELL_TYPE_NUMERIC:{
	                cellValue = String.valueOf(cell.getNumericCellValue());
	                break;
	            }
	            case Cell.CELL_TYPE_FORMULA:{
	                //判断cell是否为日期格式
	                if(DateUtil.isCellDateFormatted(cell)){
	                    //转换为日期格式YYYY-mm-dd
	                    cellValue = String.valueOf(cell.getDateCellValue());
	                }else{
	                    //数字
	                    cellValue = String.valueOf(cell.getNumericCellValue());
	                }
	                break;
	            }
	            case Cell.CELL_TYPE_STRING:{
	                cellValue = cell.getRichStringCellValue().getString();
	                break;
	            }
	            default:
            }
        }
        return cellValue;
    }

}