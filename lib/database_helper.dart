import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static const String DATABASE_NAME = 'JaagrukInformation.db';
  static const String TABLE_USER = 'user_table';
  static const String COL_MOBILE = 'Mobile';
  static const String COL_NAME = 'Name';
  static const String COL_GENDER = 'Gender';
  static const String COL_AGE = 'Age';
  static const String COL_LABOUR_TYPE = 'Labour_Type';
  static const String COL_EDUCATION = 'Education';
  static const String COL_HANDICAPPED = 'Handicapped';
  static const String COL_DISTRICT = 'District';
  static const String COL_SOCIAL_CLASS = 'Social_Class';
  static const String COL_LOGGED_IN = 'Loged_In';

  static const String TABLE_YOJNA = 'yojna_table';
  static const String COL_Y_NAME = 'Name';
  static const String COL_Y_CATEGORY = 'Category';
  static const String COL_Y_GENDER = 'Gender';
  static const String COL_Y_AGE = 'Age';
  static const String COL_Y_HANDICAPPED = 'Handicapped';
  static const String COL_Y_DESC = 'Y_Desc';
  static const String COL_Y_LINK = 'Y_LINK';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DATABASE_NAME);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_USER(
        $COL_MOBILE TEXT PRIMARY KEY,
        $COL_NAME TEXT,
        $COL_GENDER TEXT NOT NULL,
        $COL_LABOUR_TYPE TEXT,
        $COL_EDUCATION TEXT,
        $COL_HANDICAPPED INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $TABLE_YOJNA(
        $COL_Y_NAME TEXT NOT NULL,
        $COL_Y_CATEGORY TEXT NOT NULL,
        $COL_Y_GENDER TEXT NOT NULL,
        $COL_Y_AGE TEXT,
        $COL_Y_HANDICAPPED INTEGER,
        $COL_Y_DESC TEXT,
        $COL_Y_LINK TEXT
      )
    ''');

    // Initial data inserts
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('आयुष्मान भारत-प्रधानमंत्री जन आरोग्य योजना', 'Health', 'All', 'All', 0,
      'PM-JAY दुनिया की सबसे बड़ी स्वास्थ्य बीमा योजना है जो पूरी तरह से सरकार द्वारा वित्तपोषित है। भारत में सार्वजनिक और निजी सूचीबद्ध अस्पतालों में माध्यमिक और तृतीयक देखभाल अस्पताल में भर्ती के लिए प्रति परिवार प्रति वर्ष 5 लाख रुपये का कवर प्रदान करती है।',
      'https://ayushmanbharat.mp.gov.in/')
    ''');

    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('पीएम सूर्य घर योजना ','Finance','All','All','false','इस योजना मे मध्यम एवं गरीब वर्ग के परिवारों को महंगे बिजली के बिल से निजात दिलाने के लिए देश के 1 करोड़ घरो मे सोलर पैनल लगाने का अभियान शुरू किया गया है| पीएम सूर्यघर मुफ्त बिजली योजना अभियान से ग्रीन एनर्जी मिशन को बढावा देकर पर्यावरण का संतुलन बनाए रखने मे मदद होगी साथ ही रोजगार के नए अवसर पैदा होंगे |','https://www.pmsuryaghar.gov.in/consumerLogin')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES (मुख्यमंत्री जन कल्याण संबल 2.0 योजना','Finance','All','18-50 से अधिक','false','योजनांतर्गत अंत्येष्टि सहायता रू 5 हजार सामान्य मृत्यु सहायता रू 2 लाख दुर्घटना मृत्यु सहायता रू. 4 लाख आंशिक दिव्यांगता सहायता रू. 1 लाख एवं थायी दिव्यांगता सहायता योजना रू. 2 लाख की सहायता राशि।','https://sambal.mp.gov.in/Public/Survey/ShramikRegApplicationeKYC.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('प्रधानमंत्री सुरक्षा बीमा योजना','SocialSecurity','All','18-50 से अधिक','false','प्रधानमंत्री सुरक्षा बीमा योजना (Pradhan Mantri Suraksha Bima Yojana) भारत सरकार की दुर्घटना बीमा पॉलिसी है. इस पॉलिसी के तहत किसी दुर्घटना के समय मृत्यु अथवा अपंग होने पर बीमा के राशि के लिए क्लेम किया जा सकता है. मृत्यु अथवा पूर्णतः विकलांगता पर 2 लाख रूपये और आंशिक तौर पर अपंग होने पर 1 लाख रुपये की बीमा राशि दी जाती है. यह बीमा एक साल के लिए होता है और इसे हर एक साल बाद रिन्यू करवाना होगा.','https://www.india.gov.in/form-pradhan-mantri-suraksha-bima-yojna')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('प्रधानमंत्री जीवन ज्योति बीमा योजना ','SocialSecurity','All','18-50 से अधिक','false','इस योजना के तहत जोखिम कवरेज 2.00 लाख रुपये है, जिसमें बीमित की मौत के मामले में किसी भी कारण से व्यक्ति की मृत्यु पर 2 लाख रुपये देय है। देय प्रीमियम रु. 436/- प्रति वर्ष प्रति ग्राहक है।,','https://www.jansuraksha.gov.in/Forms-PMJJBY.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('पप्रधानमंत्री श्रम योगी मान-धन ','SocialSecurity','All','18-50 से अधिक','false','प्रधानमंत्री श्रम योगी मानधन वृद्धावस्था संरक्षण और असंगठित श्रमिकों की सामाजिक सुरक्षा के लिए एक सरकारी पेंशन योजना है। 60 वर्ष की आयु प्राप्त करने के बाद मासिक पेंशन 3000 रुपये प्रदान करती है।','https://maandhan.in/maandhan/login')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('प्रधानमंत्री रोजगार प्रोत्साहन योजना','SocialSecurity','All','All','false','नए कर्मचारियों के लिए सरकार 15000 से कम कमाई वाले कर्मचारियों के लिए कार्योद्घाटन योजना (EPS) और कर्मचारी भविष्य निधि (EPF) के लिए नियोक्ताओं की पूरी राशि का भुगतान करेगी','https://labour.gov.in/pradhan-mantri-rojgar-protsahan-yojanapmrpy\n')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('इंदिरा गांधी राष्ट्रीय वृद्धावस्था पेंशन योजनाा','SocialSecurity','All','50 से अधिक','false','इस योजना के तहत, 60 वर्ष या उससे अधिक आयु के बीपीएल व्यक्तियों को मासिक पेंशन ₹200/- 79 वर्ष की आयु तक और ₹500/- अधिकतम 80 वर्ष की आयु तक है।','https://socialsecurity.mp.gov.in/Scheme/SSOAP.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('इंदिरा गांधी राष्ट्रीय विकलांग पेंशन योजना','SocialSecurity','All','18-50 से अधिक','true','इंदिरा गांधी राष्ट्रीय विकलांग पेंशन योजना 18-59 वर्ष की आयु वाले गरीब व्यक्तियों को गंभीर और बहु-विकलांगता से पीड़ित होने पर मासिक पेंशन ₹ 200/- का हक है।','https://web.umang.gov.in/web_new/login?redirect_to=home')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('राष्ट्रीय पारिवारिक लाभ योजना','SocialSecurity','All','18-50 से अधिक','false',' योजना में गरीबी रेखा से नीचे जीवनयापन करने वाले परिवार के \"कमाऊ मुखिया \" (महिला या पुरूष), जिसकी आयु 18 वर्ष से अधिक एवं 60 वर्ष से कम की मृत्यु हो जाने की दशा में उसके आश्रित को धनराशि रू0 30,000/- (रू.  तीस हजार मात्र) की एकमुश्त आर्थिक सहायता दिये जाने का प्राविधान है।','https://nfbs.upsdc.gov.in/NFBS2022_23/index.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('दीन दयाल अंत्योदय योजना','Skill','All','18-50 से अधिक','false','शहरी गरीबों के प्रशिक्षण पर प्रति व्यक्ति रुपये 15,000 की खर्च की अनुमति है, जो उत्तर-पूर्व और जम्मू-कश्मीर में रुपये 18,000 है। साथ ही, शहरी नागरिकों की भारी मांग को पूरा करने के लिए शहरी जीविका केंद्रों के माध्यम से बाजार-अनुकूल कौशल प्रदान करके शहरी गरीबों का प्रशिक्षण।','https://www.xn--i1bj3fqcyde.xn--11b7cb3a6a.xn--h2brj9c/spotlight/%E0%A4%A6%E0%A5%80%E0%A4%A8%E0%A4%A6%E0%A4%AF%E0%A4%BE%E0%A4%B2-%E0%A4%85%E0%A4%82%E0%A4%A4%E0%A5%8D%E0%A4%AF%E0%A5%8B%E0%A4%A6%E0%A4%AF-%E0%A4%AF%E0%A5%8B%E0%A4%9C%E0%A4%A8%E0%A4%BE')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('कौशल विकास योजनाा','Skill','All','18-50 से अधिक','false','मध्‍यप्रदेश के शिल्‍पी/बुनकरों को शिल्‍प उन्‍नयन प्रशिक्षण उपलब्‍ध कराया जाना (संस्‍थागत प्रशिक्षण के माध्‍यम से)','https://mp.mygov.in/node/3741/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री लाड़ली बहन योजना','Finance','महिला','18-50 से अधिक','false','मध्य प्रदेश की 21 से 60 वर्ष की आयु की सभी महिलाओं को मासिक रूप से निरंतर रूप से 1,500 रुपये मिलेंगे।','https://cmladlibahna.mp.gov.in/AboutUs.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री कन्या विवाह योजना','Finance','महिला','18-50 से अधिक','false','गरीब, जरुरतमंद, निराश्रित/निर्धन परिवारों की निर्धन एवं श्रमिक संवर्ग की योजनाओं के अंतर्गत पंजीकृत हितग्राहियों के परिवार की विवाह योग्य कन्या/ विधवा/ परित्यक्तता के विवाह/निकाह हेतु आर्थिक सहायता उपलब्ध कराना है। कन्याओं की गृहस्थी की स्थापना हेतु रूपये 49,000/-कन्या को एकाउंट पेयी चैक के माध्\u200Dयम से दिये जाते है','https://socialjustice.mp.gov.in/schemes/view/SWhoak9tZGNSMnpISG9jbndQckN4UT09')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री कन्या अभिभावक पेंशन योजना','SocialSecurity','महिला','50 से अधिक','false','60 वर्ष से अधिक आयु के दं\u200Dपत्ति के यहां केवल कन्\u200Dयाऐं होने पर दं\u200Dपत्ति में से किसी 1 को कन्\u200Dया अभिभावक पेंशन योजना का लाभ प्रदाय किया जाता हैं । 60 वर्ष से आयु होने पर पति या पत्नि में से किसी 1 को राज्\u200Dय शासन द्वारा 600 /- रू. प्रतिमाह प्रदाय की जाती हैं','https://socialsecurity.mp.gov.in/Scheme/KAPS.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('विद्यार्थी कल्‍याण योजना','Finance','All','18-50 से अधिक','false','छात्रावास मे निवासरत रहते हुए अनुसूचित जति वर्ग के विद्यार्थी की मृत्‍यु होने पर एवं आर्थिक रूप से कमजोर विद्यार्थियों को आकस्मिक विपत्ति, विशेष रोग से पीड़ित होने पर इलाज हेतु, विभिन्न प्रकार के कार्यक्रमों में भाग लेने हेतु एवं विशेष अभिरूचि को प्रोत्साहन देने हेतु योजनांतर्गत सहायता दी जाती है जिससे विद्यार्थियों के अध्ययन में किसी प्रकार की रूकावट न हो.  राशि 1000- से 25000 तक ','https://scdevelopmentmp.nic.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('वदिव्यांग विद्यार्थियों को शोध छात्रवृत्ति','Finance','All','18-50 से अधिक','false','पी.एच.डी के शोर्ध कार्य हेतु भारत के किसी भी विश्वविद्यालय में शोध उपाधि समिति में साक्षात्कार के उपरान्त पंजीयन कराया हो एवं पंजीयन प्रमाण पत्र विश्वविद्यालय द्वारा जारी किया गया हो। उनको कुल राशि रू 16000/- प्रतिमाह राशि रूपये 1,92,000/- प्रतिवर्ष । ','https://highereducation.mp.gov.in/?page=r%2BDnBkqrUf40vSrJsqR2Dw%3D%3D&leftid=ZnGWU%2BxYVl5%2BNBOUmwU4dg%3D%3D')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मध्‍य प्रदेश के स्‍थाई निवासी ऐसे माता -पिता जो अपनी पुत्री को रक्षा सेवाओं में भर्ती कराते हैं उन्‍हे प्रोत्‍साहन के रूप में सम्‍मान राशि','Finance','All','18-50 से अधिक','false','संचालनालय सैनिक कल्‍याण मध्‍य प्रदेश भोपाल से संंबंधित जिला सैनिक कल्‍याण कार्यालय को राशि आबंटित की जाती है। सम्‍मान राशि जिला सैनिक कल्‍याण कार्यालय से हितग्राही के बैंक खाता में जमा की जाती है। रूपये 10, 000/- प्रतिवर्ष ','https://mp.gov.in/home-department')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('दिव्यांग छात्रवृत्ति','Finance','All','18-50 से अधिक','true','दिव्यांग विद्यार्थियों के शिक्षण हेतु छात्रवृत्ति, दृष्टिबाधित दिव्यांगगजनों को वाचक भत्ता एवं दिव्यांग विद्यार्थियों को प्रोत्सा‍हन राशि प्रदान की जाती है। ','https://socialjustice.mp.gov.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री उद्यम क्रांति योजना','Finance','All','18-50 से अधिक','false','वित्तीय सहायता के रूप में वितरित ऋण पर 3% प्रतिवर्ष ब्याज अनुदान और बैंक ऋण गारंटी फीस, अधिकतम 7 वर्षो के लिये दिए जाने का प्रावधान है।','https://samast.mponline.gov.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('प्रधानमंत्री रोजगार सृजन कार्यक्रमा','Finance','All','18-50 से अधिक','false','शहरीय एवं ग्रामीण क्षेत्र के बेरोजगार नव युवकों को स्‍वरोजगार प्रदान कराना तथा कुल परियोजना लागत के अनुसार 15-35% की सहायता ','https://www.kviconline.gov.in/pmegpeportal/pmegphome/index.jsp')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री जनकल्याण (शिक्षा प्रोत्साहन) योजना','Education','All','18-50 से अधिक','false','इस योजना के अंतर्गत जिन विद्यार्थियों के माता/पिता का म0प्र0 शासन के श्रम विभाग में असंगठित कर्मकार के रूप में पंजीयन हो, ऐसे विद्यार्थियों को निम्‍नांकित स्‍नातक/पॉलीटेकनिक डिप्‍लोमा/आईटीआई पाठयक्रमों में प्रवेश प्राप्‍त करने पर मुख्‍यमंत्री जनकल्‍याण (शिक्षा प्रोत्‍साहन) योजना के अंतर्गत शिक्षण शुल्‍क राज्‍य शासन द्वारा वहन किया जायेगा। ','https://scholarshipportal.mp.nic.in/Index.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री मेधावी विद्यार्थी योजना','Education','All','18-50 से अधिक','false','माध्यमिक शिक्षा मण्डकल की बारहवीं की परीक्षा में 70 प्रतिशत अंक प्राप्त करने वाले विद्यार्थियों एवं सीबीएसई/आईसीएसई द्वारा आयोजित बारहवीं की परीक्षा में 85 प्रतिशत या उससे अधिक अंक प्राप्त करने वाले विद्यार्थियों को योजना का लाभ प्राप्त होगा।','https://scholarshipportal.mp.nic.in/Index.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री प्रसूति सहायता योजना','SocialSecurity','All','18-50 से अधिक','false','पंजीकृत असंगठित श्रमिक अथवा पंजीकृत श्रमिक की पत्नी हितलाभ के पात्र।योजना में कुल 16 हजार रुपये की सहायता ','https://sambal.mp.gov.in/Public/Survey/ShramikRegApplicationeKYC.aspx')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('मुख्यमंत्री अविवाहिता पेंशन योजना','SocialSecurity','All','50 से अधिक','false','प्रदेश में निवासरत 50 वर्ष से अधिक आयु की अविवाहित महिलाओं को सामाजिक सुरक्षा प्रदान करने व जीवन निर्वाह हेतु प्रतिमाह 600 रुपये की आर्थिक सहायता  ','https://socialsecurity.mp.gov.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('श्रम कल्याण मण्डल','SocialSecurity','All','18-50 से अधिक','false','श्रम कल्याण एवं कौशल उन्न्यन केंद्रों का संचालन, श्रम कल्याण मंडल अंतर्गत आने वाले श्रमिकों को कुल 12 योजनाओं का लाभ । विवाह सहायता योजना, अंतिम संस्कार सहायता योजना, कल्याणी सहायता योजना प्रमुख योजनाएं ।','https://shramkalyanmandal.mponline.gov.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('राशन की पात्रता पर्ची जारी करना |','SocialSecurity','All','18-50 से अधिक','false','अंत्योदय परिवार सहित प्राथमिकता परिवार श्रेणी अंतर्गत सत्यापित 28 श्रेणी के गरीब परिवारो को पात्रता पर्ची जारी करना','https://rationmitra.nic.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('छः वर्ष से अधिक आयु के बहुविकलांग और मानसिक रूप से अविकसित निःशक्तजन के लिए सहायता अनुदान योजना','SocialSecurity','All','18-50 से अधिक','true','छः वर्ष से अधिक आयु के बहुविकलांग और मानसिक रूप से अविकसित निःशक्तजनों  को उनके जीविकोपार्जन हेतु रू 600/- प्रतिमाह सहायता अनुदान के रूप में दिये जाने का ','https://socialsecurity.mp.gov.in/')")
    ''');
    await db.execute('''
      INSERT INTO $TABLE_YOJNA ($COL_Y_NAME, $COL_Y_CATEGORY, $COL_Y_GENDER, $COL_Y_AGE, $COL_Y_HANDICAPPED, $COL_Y_DESC, $COL_Y_LINK)
      VALUES ('नि:शक्तजन विवाह प्रोत्साहन योजना','Finance','All','18-50 से अधिक','false','निःशक्त व्यक्तियों के सामाजिक पुनर्वास को सुनिश्चित करने के लिये निःशक्तजन विवाह प्रोत्साहन योजना सामाजिक न्याय एवं निःशक्तजन कल्याण विभाग द्वारा प्रारम्भ की गई है। योजनान्तार्गत 1. युवक के निःशक्त होने पर सामान्य युवती से तथा युवती के निःशक्त होने पर सामान्य युवक से विवाह होने पर राशि रू. 2,00,000/- प्रोत्साहन राशि तथा युवक एवं युवती दोनों के निःशक्त होने पर संयुक्त रुप से रु. 1,00,000/- प्रोत्साहन राशि प्रदान की जाती है।','https://socialjustice.mp.gov.in/" +
                "')
    ''');

    // Add more inserts as needed for other schemes
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS $TABLE_USER');
    await db.execute('DROP TABLE IF EXISTS $TABLE_YOJNA');
    await _createDatabase(db, newVersion);
  }

  Future<bool> insertUserData(String mobile, String name, String labourType, bool handicapped, bool loggedIn, String education, String district, String gender, String age, String cast) async {
    final db = await database;
    Map<String, dynamic> row = {
      COL_MOBILE: mobile,
      COL_NAME: name,
      COL_GENDER: gender,
      COL_LABOUR_TYPE: labourType,
      COL_EDUCATION: education,
      COL_HANDICAPPED: handicapped ? 1 : 0,
      COL_DISTRICT: district,
      COL_AGE: age,
      COL_LOGGED_IN: loggedIn ? 1 : 0,
      // Add more columns as needed
    };
    int result = await db.insert(TABLE_USER, row);
    return result != 0;
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    final db = await database;
    return await db.query(TABLE_USER);
  }

  Future<List<Map<String, dynamic>>> getYojna(String category, String age, String gender) async {
    final db = await database;
    String query;
    if (age == null || age.isEmpty) {
      query = "SELECT * FROM $TABLE_YOJNA WHERE $COL_Y_CATEGORY = ? AND ($COL_Y_AGE = '18-50 से अधिक' OR $COL_Y_AGE = 'All') AND ($COL_Y_GENDER = 'All' OR $COL_Y_GENDER = ?)";
      return await db.rawQuery(query, [category, gender]);
    } else {
      query = "SELECT * FROM $TABLE_YOJNA WHERE $COL_Y_CATEGORY = ? AND ($COL_Y_AGE = 'All' OR $COL_Y_GENDER = ?)";
      return await db.rawQuery(query, [category, gender]);
    }
  }

  Future<Map<String, dynamic>> getUserDataViaMobile(String mobile) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(TABLE_USER, where: '$COL_MOBILE = ?', whereArgs: [mobile]);
    return result.isNotEmpty ? result.first : {};
  }

  Future<void> deleteUser(String mobile) async {
    final db = await database;
    await db.delete(TABLE_USER, where: '$COL_MOBILE = ?', whereArgs: [mobile]);
  }
}
