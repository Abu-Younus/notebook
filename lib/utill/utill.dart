class Util{
  static String greeting(){
    String message = '';

    int hour = DateTime.now().hour;
    if(hour>=0 && hour<6){
      message = "Good Night";
    }else  if(hour>=6 && hour<12){
      message = "Good Morning";
    } else if (hour >= 12 && hour < 16) {
      message = "Good Afternoon";
    } else if (hour >= 16 && hour < 21) {
      message = "Good Evening";
    } else if (hour >= 21 && hour < 24) {
      message = "Good Night";
    }

    return message;
  }
}
