
import '../../model/data_article.dart';

class DataArticle
{
  static List<ArticlePost> dataArticle=[];
  static List<ArticlePost> dataArticleDashboard=[];

  static void getTop5()
  {
    List<ArticlePost> tmp=[];
    for(int i=0;i<5;i++)
      {
        tmp.add(dataArticleDashboard[i]);
      }
    dataArticleDashboard=tmp;
  }
  static void deletePost(String id)
  {
    for(int i=0;i<dataArticle.length;i++)
      {
        if(dataArticle[i].id?.compareTo(id)==0)
          {
            dataArticle.removeAt(i);
            break;
          }
      }
  }
}