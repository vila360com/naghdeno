import 'package:flutter/material.dart';
import '../controllers/app_state.dart';
import '../models/book_models.dart';
import '../theme/app_theme.dart';

class ReaderScreen extends StatefulWidget {
  final String bookId;
  final int chapterIndex;

  const ReaderScreen({
    super.key,
    required this.bookId,
    this.chapterIndex = 0,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late int _currentChapterIndex;

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.chapterIndex;
  }

  void _showSettingsModal(BuildContext context, AppState appState) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تنظیمات کتاب‌خوان',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Theme Selection
                  const Text('تم صفحه:'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: appState.readerTheme == 'light'
                                ? const BorderSide(color: Colors.blue, width: 2)
                                : null,
                          ),
                          onPressed: () {
                            appState.setReaderTheme('light');
                            setModalState(() {});
                          },
                          child: const Text('روشن',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppTheme.sepiaBackground,
                            side: appState.readerTheme == 'sepia'
                                ? const BorderSide(color: Colors.blue, width: 2)
                                : null,
                          ),
                          onPressed: () {
                            appState.setReaderTheme('sepia');
                            setModalState(() {});
                          },
                          child: const Text('سپیا',
                              style: TextStyle(color: AppTheme.sepiaText)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF121212),
                            side: appState.readerTheme == 'dark'
                                ? const BorderSide(color: Colors.blue, width: 2)
                                : null,
                          ),
                          onPressed: () {
                            appState.setReaderTheme('dark');
                            setModalState(() {});
                          },
                          child: const Text('تاریک',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Font Size
                  Text(
                    'اندازه متن: ${appState.readerFontSize.toInt()} pt',
                  ),
                  Slider(
                    value: appState.readerFontSize,
                    min: 14.0,
                    max: 28.0,
                    divisions: 14,
                    onChanged: (val) {
                      appState.setReaderFontSize(val);
                      setModalState(() {});
                    },
                  ),

                  // Line Height
                  Text(
                    'فاصله خطوط: ${appState.readerLineHeight.toStringAsFixed(1)}',
                  ),
                  Slider(
                    value: appState.readerLineHeight,
                    min: 1.4,
                    max: 2.4,
                    divisions: 10,
                    onChanged: (val) {
                      appState.setReaderLineHeight(val);
                      setModalState(() {});
                    },
                  ),
                ],
              ),
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

    if (book == null || book.chapters.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطا')),
        body: const Center(child: Text('محتوای کتاب در دسترس نیست.')),
      );
    }

    final chapter = book.chapters[_currentChapterIndex];

    Color bgColor;
    Color textColor;

    switch (appState.readerTheme) {
      case 'sepia':
        bgColor = AppTheme.sepiaBackground;
        textColor = AppTheme.sepiaText;
        break;
      case 'dark':
        bgColor = const Color(0xFF121212);
        textColor = const Color(0xFFE0E0E0);
        break;
      case 'light':
      default:
        bgColor = Colors.white;
        textColor = Colors.black87;
        break;
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        title: Text(
          book.title,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'افزودن نشانک',
            onPressed: () {
              appState.addBookmark(
                Bookmark(
                  id: DateTime.now().toString(),
                  bookId: book.id,
                  chapterIndex: _currentChapterIndex,
                  chapterTitle: chapter.title,
                  snippet: chapter.content.length > 50
                      ? '${chapter.content.substring(0, 50)}...'
                      : chapter.content,
                  createdAt: DateTime.now(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('نشانک با موفقیت ذخیره شد.')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'تنظیمات نمایش',
            onPressed: () => _showSettingsModal(context, appState),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.title,
                      style: TextStyle(
                        fontSize: appState.readerFontSize + 4,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      chapter.content,
                      style: TextStyle(
                        fontSize: appState.readerFontSize,
                        height: appState.readerLineHeight,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Chapter Control Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                    ),
                    onPressed: _currentChapterIndex > 0
                        ? () {
                            setState(() {
                              _currentChapterIndex--;
                            });
                            appState.updateProgress(
                              book.id,
                              _currentChapterIndex,
                              (_currentChapterIndex + 1) / book.chapters.length,
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('فصل قبلی'),
                  ),
                  Text(
                    '${_currentChapterIndex + 1} از ${book.chapters.length}',
                    style: TextStyle(color: textColor),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _currentChapterIndex < book.chapters.length - 1
                        ? () {
                            setState(() {
                              _currentChapterIndex++;
                            });
                            appState.updateProgress(
                              book.id,
                              _currentChapterIndex,
                              (_currentChapterIndex + 1) / book.chapters.length,
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('فصل بعدی'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
