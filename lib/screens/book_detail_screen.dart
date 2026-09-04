import 'package:flutter/material.dart';
import '../controllers/app_state.dart';
import '../models/book_models.dart';
import '../widgets/rating_stars.dart';
import '../widgets/review_tile.dart';
import '../widgets/shelf_badge.dart';
import 'reader_screen.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final _reviewController = TextEditingController();
  double _userRating = 5.0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _showAddReviewDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('ثبت نقد و بررسی'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('امتیاز شما:'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starRating = index + 1.0;
                        return IconButton(
                          icon: Icon(
                            starRating <= _userRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              _userRating = starRating;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _reviewController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'نظر خود درباره این کتاب را بنویسید...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('انصراف'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_reviewController.text.trim().isNotEmpty) {
                      appState.submitReview(
                        Review(
                          id: DateTime.now().toString(),
                          bookId: widget.bookId,
                          userName: 'کاربر نقد نو',
                          userAvatar: 'https://i.pravatar.cc/150?img=3',
                          rating: _userRating,
                          content: _reviewController.text.trim(),
                          date: DateTime.now(),
                        ),
                      );
                      _reviewController.clear();
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('نقد شما با موفقیت ثبت شد.'),
                        ),
                      );
                    }
                  },
                  child: const Text('ثبت'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final book = appState.repository.getBookById(widget.bookId);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطا')),
        body: const Center(child: Text('کتاب مورد نظر پیدا نشد.')),
      );
    }

    final currentShelf = appState.getShelfType(book.id);
    final reviews = appState.getReviews(book.id);
    final discussions = appState.getDiscussions(bookId: book.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          PopupMenuButton<ShelfType?>(
            initialValue: currentShelf,
            icon: const Icon(Icons.bookmark_add_outlined),
            tooltip: 'تغییر قفسه',
            onSelected: (shelf) {
              appState.setShelfType(book.id, shelf);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ShelfType.currentlyReading,
                child: Text('افزودن به «در حال خواندن»'),
              ),
              const PopupMenuItem(
                value: ShelfType.wantToRead,
                child: Text('افزودن به «می‌خواهم بخوانم»'),
              ),
              const PopupMenuItem(
                value: ShelfType.read,
                child: Text('افزودن به «خوانده‌شده»'),
              ),
              if (currentShelf != null)
                const PopupMenuItem(
                  value: null,
                  child: Text(
                    'حذف از کتابخانه',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover and Header info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.coverUrl,
                    width: 110,
                    height: 165,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      width: 110,
                      height: 165,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.book, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'نویسنده: ${book.author}',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      if (book.translator != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'مترجم: ${book.translator}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingStars(rating: book.rating, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${book.rating} (${book.ratingCount} نظر)',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (currentShelf != null) ShelfBadge(shelfType: currentShelf),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Read Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReaderScreen(bookId: book.id),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text(
                  'شروع مطالعه',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              'درباره کتاب',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: const TextStyle(height: 1.6, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Chapters List
            Text(
              'فصل‌های کتاب (${book.chapters.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: book.chapters.length,
              itemBuilder: (context, index) {
                final chapter = book.chapters[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(chapter.title),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          bookId: book.id,
                          chapterIndex: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),

            // Reviews Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'نقدها و نظرات (${reviews.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddReviewDialog(context, appState),
                  icon: const Icon(Icons.add_comment),
                  label: const Text('ثبت نقد'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (reviews.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('هنوز نقدی برای این کتاب ثبت نشده است.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewTile(review: reviews[index]);
                },
              ),
            const SizedBox(height: 24),

            // Discussion threads preview
            if (discussions.isNotEmpty) ...[
              Text(
                'گفتگوهای درباره این کتاب',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...discussions.map((thread) => Card(
                    child: ListTile(
                      title: Text(thread.title),
                      subtitle: Text(
                        'ایجاد شده توسط ${thread.authorName} - ${thread.comments.length} نظر',
                      ),
                      leading: const Icon(Icons.forum),
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
