import 'package:admin_ipa/services/articles_service.dart';
import 'package:admin_ipa/services/company_service.dart';
import 'package:admin_ipa/services/experience_service.dart';
import 'package:admin_ipa/services/qa_service.dart';
import 'package:admin_ipa/services/report_comment_service.dart';
import 'package:admin_ipa/services/topic_service.dart';
import 'package:admin_ipa/services/user_blocked_service.dart';

class DatabaseService
    with
        ArticlePostHandle,ExperienceService,TopicService, QAService,CompanyService,CommentReportService,UserBlockedService {}