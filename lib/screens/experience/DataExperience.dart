

import '../../model/data_experience.dart';

class DataExperience
{
  static List<ExperiencePost> dataExperience=[];

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