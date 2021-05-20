# OnePieceQuiz

これは、クイズの投稿や閲覧、解答ができるアプリケーションです。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install --without production
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、Railsサーバーを立ち上げてください。

```
$ rails server
```