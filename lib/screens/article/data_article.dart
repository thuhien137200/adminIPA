
import '../../model/data_article.dart';

class DataArticle
{
  static List<ArticlePost> dataArticle=[];

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