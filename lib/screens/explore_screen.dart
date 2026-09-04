import 'package:flutter/material.dart';
import '../controllers/app_state.dart';
import '../widgets/book_card.dart';
import 'book_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'همه';

  final List<String> _categories = [
    'همه',
    'ادبیات داستانی',
    'رمان تاریخی - سیاسی',
    'ادبیات جهان',
    'رمان ایرانی',
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final allBooks = appState.repository.getAllBooks();

    final filteredBooks = allBooks.where((book) {
      final matchesQuery = book.title.contains(_searchQuery) ||
          book.author.contains(_searchQuery) ||
          (book.translator != null && book.translator!.contains(_searchQuery));
      final matchesCategory =
          _selectedCategory == 'همه' || book.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('نقد نو | نقد و بررسی کتاب'),
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'جستجوی نام کتاب، نویسنده یا مترجم...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Categories Filter list
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                    checkmarkColor: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Book List
          Expanded(
            child: filteredBooks.isEmpty
                ? const Center(
                    child: Text('کتابی یافت نشد!'),
                  )
                : ListView.builder(
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookCard(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailScreen(bookId: book.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
