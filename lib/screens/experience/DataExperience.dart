

import '../../model/data_experience.dart';

class DataExperience
{
  static List<ExperiencePost> dataExperience=[];
  static List<ExperiencePost> dataExperienceDashboard=[];

  static void getTop5()
  {
    List<ExperiencePost> tmp=[];
    for(int i=0;i<5;i++)
    {
      tmp.add(dataExperienceDashboard[i]);
    }
    dataExperienceDashboard=tmp;
  }
  static void updateList(String id)
  {
    for(int i=0;i<dataExperience.length;i++)
      {
        if(dataExperience[i].post_id?.compareTo(id)==0)
          {
            dataExperience[i].isApproved=true;
            break;
          }
      }
  }
}