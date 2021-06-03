import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get urlToImage => text().nullable()();

  TextColumn get publishedAt => text().nullable()();

  TextColumn get content => text().nullable()();
}

@UseMoor(tables: [Articles], daos: [ArticleDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;
}

@UseDao(
  tables: [Articles],
)
class ArticleDao extends DatabaseAccessor<AppDatabase> with _$ArticleDaoMixin {
  final AppDatabase db;

  ArticleDao(this.db) : super(db);

  Future<List<Article>> getAllTasks() => select(articles).get();

  Stream<List<Article>> watchAllTasks() => select(articles).watch();

  Future insertArticle(Insertable<Article> article) =>
      into(articles).insert(article);

  Future deleteTask(Insertable<Article> article) =>
      delete(articles).delete(article);
}
