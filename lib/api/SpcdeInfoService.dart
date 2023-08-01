import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 공공 DATA - 특일 정보 (SpcdeInfoService)
// 활용기간	2023-07-24 ~ 2025-07-24
// 배포용 따로 신청 필요한거같음..
// getHoliDeInfo	국경일 정보조회
// getRestDeInfo	공휴일 정보조회
// getAnniversaryInfo	기념일 정보조회
// get24DivisionsInfo	24절기 정보조회
// getSundryDayInfo	잡절 정보조회

// api 파라미터
// solYear	연	2015	연
// solMonth	월	08	월
// ServiceKey	서비스키			발급받은 서비스키
// _type	json 타입 (디폴트 XML)	json	json 타입으로 활용시 추가
// numOfRows	한페이지 결과 수		20	한페이지에 모든 결과를 확인할 때 추가(디폴트 10)

// api 기본정보
const BASE_API_URL = 'http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService';
// ENCODING_KEY 와 DECODING_KEY 같아서 하나의 변수로 설정
var SERVICE_KEY = dotenv.env['SERVICE_KEY'];
// sample URL
var sampleUrl = 'http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?solYear=2019&solMonth=03&ServiceKey=$SERVICE_KEY';

const RETURN_TYPE = "json";
const NUM_OF_ROWS = 20; // default : 10

// api 리스트
const String GET_HOLI_DE_INFO = "getHoliDeInfo"; // 국경일 정보조회
const String GET_REST_DE_INFO = "getRestDeInfo"; // 공휴일 정보조회
const String GET_ANNIVERSARY_INFO = "getAnniversaryInfo"; // 기념일 정보조회
const String GET_24DivisionsInfo = "get24DivisionsInfo"; // 24절기 정보조회
const String GET_SUNDRY_DAY_INFO = "getSundryDayInfo"; // 잡절 정보조회

class SpcdeInfoService {
  Future<dynamic> getSpcdeInfo(
      {required String type, required int year, required int month}) async {
    String reqUrl = "$BASE_API_URL/$type";
    String reqParam = setParam(year: year, month: month);
    Response response = await Dio().get(reqUrl + reqParam  );

    var data = response.data;
    var totalCount = data['response']['body']['totalCount'];
    var items = totalCount > 0 ?  data['response']['body']['items']['item'] : [];

    var result = [];
    if(totalCount == 1){
      result = [items]; // 1건
    }else if(totalCount > 1){
      result = items as List; // 2건 이상
    }

    // print('result : $result');
    return result;
  }

  String setParam({required int year, required int month}) {
    var buffer = StringBuffer();
    buffer.write("?solYear=${year.toString()}");
    buffer.write("&solMonth=${month.toString().padLeft(2,"0")}");
    buffer.write("&ServiceKey=$SERVICE_KEY");
    buffer.write("&_type=$RETURN_TYPE");
    buffer.write("&numOfRows=${NUM_OF_ROWS.toString()}");

    return buffer.toString();
  }
}
