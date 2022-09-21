class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  int? color;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.color,
    this.repeat,
  });

  Task.fromjson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    color = json['color'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note']= note;
    data['isCompleted']= isCompleted;
    data['date']= date;
    data['startTime']= startTime;
    data['endTime']= endTime;
    data['remind']= remind;
    data['color']= color;
    data['repeat'] = repeat;
    return data;
  }
}


