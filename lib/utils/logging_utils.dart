import 'dart:developer';


//* For help development progress , not all log imply on prod
class LoggingUtils{

  static void logStartFunction()
  {
    var current = DateTime.now();
    log("[Timestamp : ${current.hour}:${current.minute}:${current.second}] ON START FUNCTION");
  }

  static void logDebugValue (String data , String activity)
  {
    var current = DateTime.now();
    log("[Timestamp : ${current.hour}:${current.minute}:${current.second}] [Activity $activity] [DATA : ${data.toString}]");
  }
}

