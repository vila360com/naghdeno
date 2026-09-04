import 'package:flutter/material.dart';
import '../controllers/app_state.dart';
import '../models/book_models.dart';

class DiscussionsScreen extends StatefulWidget {
  const DiscussionsScreen({super.key});

  @override
  State<DiscussionsScreen> createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  final _threadTitleController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _threadTitleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _showNewThreadModal(BuildContext context, AppState appState) {
    String? selectedBookId = appState.repository.getAllBooks().first.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ایجاد تاپیک گفتگو جدید',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedBookId,
                    decoration: const InputDecoration(
                      labelText: 'کتاب مربوطه',
                      border: OutlineInputBorder(),
                    ),
                    items: appState.repository.getAllBooks().map((book) {
                      return DropdownMenuItem(
                        value: book.id,
                        child: Text(book.title),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setModalState(() {
                        selectedBookId = val;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _threadTitleController,
                    decoration: const InputDecoration(
                      labelText: 'عنوان یا موضوع گفتگو',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_threadTitleController.text.trim().isNotEmpty &&
                            selectedBookId != null) {
                          final book =
                              appState.repository.getBookById(selectedBookId!);
                          appState.createDiscussion(
                            DiscussionThread(
                              id: DateTime.now().toString(),
                              bookId: book!.id,
                              bookTitle: book.title,
                              title: _threadTitleController.text.trim(),
                              authorName: 'کاربر نقد نو',
                              authorAvatar: 'https://i.pravatar.cc/150?img=3',
                              date: DateTime.now(),
                              comments: [],
                            ),
                          );
                          _threadTitleController.clear();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تاپیک گفتگو با موفقیت ایجاد شد.'),
                            ),
                          );
                        }
                      },
                      child: const Text('انتشار گفتگو'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showThreadDetailModal(
      BuildContext context, AppState appState, DiscussionThread thread) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thread.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'درباره کتاب: ${thread.bookTitle} | توسط ${thread.authorName}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: thread.comments.isEmpty
                        ? const Center(
                            child: Text('هنوز نظری در این گفتگو ارسال نشده است.'),
                          )
                        : ListView.builder(
                            itemCount: thread.comments.length,
                            itemBuilder: (context, index) {
                              final comment = thread.comments[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(comment.userAvatar),
                                  ),
                                  title: Text(comment.userName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  subtitle: Text(comment.content),
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: const InputDecoration(
                              hintText: 'نظر خود را بنویسید...',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_commentController.text.trim().isNotEmpty) {
                              appState.addCommentToDiscussion(
                                thread.id,
                                DiscussionComment(
                                  id: DateTime.now().toString(),
                                  userName: 'کاربر نقد نو',
                                  userAvatar: 'https://i.pravatar.cc/150?img=3',
                                  content: _commentController.text.trim(),
                                  date: DateTime.now(),
                                ),
                              );
                              _commentController.clear();
                              setModalState(() {});
                            }
                          },
                        ),
                      ],
                    ),
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
    final discussions = appState.getDiscussions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تالار گفتگو و بحث'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewThreadModal(context, appState),
        icon: const Icon(Icons.add_comment),
        label: const Text('گفتگوی جدید'),
      ),
      body: discussions.isEmpty
          ? const Center(child: Text('هیچ گفتگویی ثبت نشده است.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                final thread = discussions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: InkWell(
                    onTap: () =>
                        _showThreadDetailModal(context, appState, thread),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(thread.authorAvatar),
                                radius: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                thread.authorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  thread.bookTitle,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            thread.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.chat_bubble_outline,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${thread.comments.length} پاسخ',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
