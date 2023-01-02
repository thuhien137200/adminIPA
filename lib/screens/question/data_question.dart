
import '../../model/data_question.dart';

class DataQuestion
{
  static List<Question> dataQuestion=[];
  static List<Question> dataQuestionDashboard=[];

  static void getTop5()
  {
    List<Question> tmp=[];
    for(int i=0;i<5;i++)
    {
      tmp.add(dataQuestionDashboard[i]);
    }
    dataQuestionDashboard=tmp;
  }
}