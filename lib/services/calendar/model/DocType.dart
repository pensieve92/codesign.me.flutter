enum DocType{
 todo('TODO', '할일'),             // 할일
 schedule('SCHEDULE', '스케줄'),   // 스케줄
 memo('MEMO', '메모');             // 메모

 const DocType(this.code, this.displayName);
 final String code;
 final String displayName;

 factory DocType.getByCode(String code){
  return DocType.values.firstWhere((value) => value.code == code,
      orElse: () => DocType.todo);
 }
}