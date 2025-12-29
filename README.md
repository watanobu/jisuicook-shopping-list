# 自炊レシピ「買い物リスト自動生成」WEBアプリ
レシピ（1人前の材料）を登録し、1週間（今日〜6日後）の献立カレンダーに割り当てると、食材名＋単位で材料を合算した買い物リストを自動生成します。調味料フラグ付きの材料は集計から除外されます。

## 前提
- Docker / Docker Compose が利用できること（ローカル運用前提）

## セットアップ
```bash
# ビルド
docker compose build

# DB作成・マイグレーション・seed投入
docker compose run --rm web bash -lc "bundle exec rails db:create db:migrate db:seed"
```

## 起動
```bash
docker compose up
# http://localhost:3000 にアクセス
```
`web` サービスは `bin/dev` を実行し、RailsサーバーとTailwindビルドを同時起動します。

## 画面と機能
- レシピ管理
  - レシピ名・写真URL（任意）・材料（食材名/数量/単位/調味料フラグ）を登録/編集
  - 材料は1行以上必須。調味料フラグONのものは買い物リストから除外
- 週間献立カレンダー
  - 今日から7日分、朝/昼/晩の各枠に複数レシピを登録可能
  - 人数（倍率）を設定し、材料数量に掛け算して集計
- 買い物リスト
  - 食材名＋単位で合算し、数量は小数で計算。表示は小数第2位で丸め
  - 調味料フラグ付き材料は除外済み

## 環境変数（抜粋）
- `MYSQL_HOST` / `MYSQL_PORT` / `MYSQL_USER` / `MYSQL_PASSWORD` / `MYSQL_DATABASE` / `MYSQL_DATABASE_TEST`
  - `docker-compose.yml` にデフォルト値あり。ローカルでそのまま使えます。

## 補足
- タイムゾーン: Asia/Tokyo、ロケール: ja
- 画像アップロードは任意要件のため未実装（写真URL欄のみ用意）
