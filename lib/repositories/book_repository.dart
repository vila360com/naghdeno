import '../models/book_models.dart';

class BookRepository {
  static final List<Book> _sampleBooks = [
    Book(
      id: '1',
      title: 'بوف کور',
      author: 'صادق هدایت',
      translator: null,
      coverUrl: 'https://picsum.photos/seed/buf/300/450',
      description:
          'بوف کور معروف‌ترین اثر صادق هدایت است، رمانی کوتاه و از نخستین داستان‌های سوررئالیستی ادبیات معاصر فارسی. این کتاب داستان نقاشی را روایت می‌کند که دچار انزوا، دغدغه‌های روحی و کابوس‌های عمیق است.',
      category: 'ادبیات داستانی',
      rating: 4.6,
      ratingCount: 1280,
      totalPages: 160,
      chapters: [
        Chapter(
          id: 'c1',
          title: 'فصل اول: زن اثیری',
          content:
              'در زندگی زخم‌هایی هست که مثل خوره روح را آهسته در انزوا می‌تراشد و می‌خورد.\n\nاین دردها را نمی‌شود به کسی اظهار کرد، چون عموماً عادت دارند که این دردهای باورنکردنی را جزء اتفاقات و پیشآمدهای نادر و عجیب بشمارند و اگر کسی بگوید یا بنویسد، مردم برسبیل عقاید جاری و عقاید خودشان با لبخند شکاک و تمسخرآمیز آن را تلقی می‌کنند.\n\nزیرا بشر هنوز چاره و دوایی برایش پیدا نکرده و تنها داروی آن فراموشی به توسط شراب و خواب مصنوعی به وسیله افیون و مواد مخدره است — ولی افسوس که تاثیر این‌گونه داروها موقت است و بجای تسکین پس از مدتی بر شدت درد می‌افزاید.\n\nآیا روزی به راز این ماورای طبیعی، این انعکاس سایهٔ روح که در حالت اغما و برزخ بین خواب و بیداری جلوه می‌کند انباشته خواهد شد؟',
        ),
        Chapter(
          id: 'c2',
          title: 'فصل دوم: پیرمرد خنزرپنزری',
          content:
              'من فقط برای سایهٔ خودم می‌نویسم که جلوی روشنایی چراغ روی دیوار افتاده است، باید خودم را به آن معرفی کنم.\n\nدر این دنیای پست پر از فقر و مسکنت، برای نخستین بار گمان کردم که در زندگی من یک شعاع آفتاب تابید — اما افسوس، این شعاع آفتاب نبود، بلکه فقط یک پرتو گذرنده، یک شهاب بود که به صورت یک زن یا فرشته به من نازل شد و در روشنایی آن یک لحظه، فقط یک ثانیه تمام بدبختی‌های زندگی خودم را دیدم و به عظمت و جلال آن پی بردم.',
        ),
      ],
    ),
    Book(
      id: '2',
      title: 'چشم‌هایش',
      author: 'بزرگ علوی',
      translator: null,
      coverUrl: 'https://picsum.photos/seed/cheshm/300/450',
      description:
          'رمان چشم‌هایش داستان استاد ماکان، نقاش بزرگ و مبارز سیاسی دوران حکومت استبدادی است. پس از مرگ استاد، ناظم مدرسهٔ صنایع مستظرفه تلاش می‌کند راز آخرین پرتره استاد با نام «چشم‌هایش» را کشف کند.',
      category: 'رمان تاریخی - سیاسی',
      rating: 4.8,
      ratingCount: 2150,
      totalPages: 272,
      chapters: [
        Chapter(
          id: 'c1',
          title: 'فصل اول: راز نقاشی',
          content:
              'استاد ماکان مردی بود که تا آخرین روزهای زندگی خود با قلم‌مو و رنگ، پرده‌هایی می‌آفرید که روح و احساسات هر بیننده‌ای را تسخیر می‌کرد.\n\nاما یکی از عجیب‌ترین و تاثیرگذارترین آثار او، پرتره‌ای بود که تنها دو چشم رازآلود زنی در آن کشیده شده بود. همه دوستداران هنر و شاگردان او در شگفت بودند که صاحبان این چشم‌های گیرا و مرموز کیست.',
        ),
        Chapter(
          id: 'c2',
          title: 'فصل دوم: دیدار با فرنگیس',
          content:
              'در یک روز بارانی پاییزی، زنی ناشناس و موقر وارد موزه آثار استاد شد. او با دقت و نگاهی پر از اندوه به پرتره نگاه می‌کرد. ناظم با احتیاط به او نزدیک شد تا بالاخره سرگذشت و هویت زن صاحب چشم‌ها را بشنود.',
        ),
      ],
    ),
    Book(
      id: '3',
      title: 'شازده کوچولو',
      author: 'آنتوان دو سنت‌اگزوپری',
      translator: 'احمد شاملو',
      coverUrl: 'https://picsum.photos/seed/littleprince/300/450',
      description:
          'شازده کوچولو داستان خلبانی است که در صحرای آفرقا فرود اضطراری کرده و با پسرک عجیبی از سیاره‌ای کوچک آشنا می‌شود. روایتی عمیق و فلسفی از عشق، دوست داشتن و دیدن جهان با چشم دل.',
      category: 'ادبیات جهان',
      rating: 4.9,
      ratingCount: 3400,
      totalPages: 112,
      chapters: [
        Chapter(
          id: 'c1',
          title: 'فصل اول: نقاشی مار بوآ',
          content:
              'وقتی شش ساله بودم روزی در کتابی به نام «قصه‌های واقعی از طبیعت» تصویر شاهکاری دیدم. تصویر یک مار بوآ بود که داشت حیوان وحشی را می‌بلعید.\n\nشاهکارم را به بزرگ‌ترها نشان دادم و پرسیدم از دیدنش می‌ترسند؟ در جوابم گفتند: «چرا باید از یک کلاه ترسید؟» اما نقاشی من کلاه نبود، مار بوآیی بود که فیل هضم می‌کرد!',
        ),
        Chapter(
          id: 'c2',
          title: 'فصل دوم: اهلی کردن روباه',
          content:
              'روباه گفت: «اگر تو مرا اهلی کنی، زندگی‌مان چون خورشید روشن خواهد شد. من صدای پایی را خواهم شناخت که با همه صداهای دیگر فرق دارد...»\n\n«آدم‌ها این حقیقت را فراموش کرده‌اند، اما تو نباید فراموش کنی. تو تا زنده‌ای مسئول آن چیزی هستی که اهلی‌اش کرده‌ای. تو مسئول گل‌ات هستی...»',
        ),
      ],
    ),
    Book(
      id: '4',
      title: 'سووشون',
      author: 'سیمین دانشور',
      translator: null,
      coverUrl: 'https://picsum.photos/seed/suvushun/300/450',
      description:
          'سووشون داستان زندگی زری و یوسف در شیراز در زمان جنگ جهانی دوم است. این رمان نخستین رمان برجسته نوشته شده توسط یک زن در ادبیات فارسی محسوب می‌شود.',
      category: 'رمان ایرانی',
      rating: 4.7,
      ratingCount: 1890,
      totalPages: 320,
      chapters: [
        Chapter(
          id: 'c1',
          title: 'فصل اول: جشنی در شیراز',
          content:
              'در خانه خان، بوی نارنج و گلاب با صدای ساز و دهل در هم آمیخته بود. زری در میان جمعیت نگاهش به یوسف بود که با نگرانی به اوضاع سیاسی شهر فکر می‌کرد.',
        ),
      ],
    ),
  ];

  static final List<Review> _sampleReviews = [
    Review(
      id: 'r1',
      bookId: '1',
      userName: 'علی رضایی',
      userAvatar: 'https://i.pravatar.cc/150?img=11',
      rating: 5.0,
      content:
          'شاهکار بی‌نظیر ادبیات مدرن ایران. توصیف‌ها و فضاسازی صادق هدایت انسان را غرق در دنیای کتاب می‌کند.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Review(
      id: 'r2',
      bookId: '1',
      userName: 'مریم احمدی',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      rating: 4.0,
      content:
          'کتابی لایه لایه و پر از نماد. هر بار که می‌خوانم برداشت تازه‌ای پیدا می‌کنم.',
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Review(
      id: 'r3',
      bookId: '2',
      userName: 'سارا حسینی',
      userAvatar: 'https://i.pravatar.cc/150?img=9',
      rating: 5.0,
      content:
          'شخصیت‌پردازی فرنگیس و استاد ماکان عالی است. یکی از جذاب‌ترین رمان‌های عاشقانه-سیاسی فارسی.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static final List<DiscussionThread> _sampleDiscussions = [
    DiscussionThread(
      id: 'd1',
      bookId: '1',
      bookTitle: 'بوف کور',
      title: 'نمادشناسی زن اثیری در بوف کور',
      authorName: 'امین کاظمی',
      authorAvatar: 'https://i.pravatar.cc/150?img=12',
      date: DateTime.now().subtract(const Duration(days: 2)),
      comments: [
        DiscussionComment(
          id: 'dc1',
          userName: 'زهرا نوری',
          userAvatar: 'https://i.pravatar.cc/150?img=20',
          content:
              'زن اثیری نماد ایده‌آل دست‌نیافتنی راوی است که در تقابل با زن لکاته قرار دارد.',
          date: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        ),
      ],
    ),
    DiscussionThread(
      id: 'd2',
      bookId: '3',
      bookTitle: 'شازده کوچولو',
      title: 'مفهوم «اهلی کردن» از نگاه سنت‌اگزوپری',
      authorName: 'رضا محمدی',
      authorAvatar: 'https://i.pravatar.cc/150?img=33',
      date: DateTime.now().subtract(const Duration(days: 5)),
      comments: [
        DiscussionComment(
          id: 'dc2',
          userName: 'مهدی کریمی',
          userAvatar: 'https://i.pravatar.cc/150?img=68',
          content:
              'اهلی کردن یعنی ایجاد پیوند و مسئولیت‌پذیری در روابط انسانی.',
          date: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
    ),
  ];

  List<Book> getAllBooks() => List.unmodifiable(_sampleBooks);

  Book? getBookById(String id) {
    try {
      return _sampleBooks.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Review> getReviewsForBook(String bookId) {
    return _sampleReviews.where((r) => r.bookId == bookId).toList();
  }

  void addReview(Review review) {
    _sampleReviews.insert(0, review);
  }

  List<DiscussionThread> getDiscussions({String? bookId}) {
    if (bookId == null) return List.unmodifiable(_sampleDiscussions);
    return _sampleDiscussions.where((d) => d.bookId == bookId).toList();
  }

  void addDiscussionThread(DiscussionThread thread) {
    _sampleDiscussions.insert(0, thread);
  }

  void addDiscussionComment(String threadId, DiscussionComment comment) {
    final thread = _sampleDiscussions.firstWhere((d) => d.id == threadId);
    thread.comments.add(comment);
  }
}
