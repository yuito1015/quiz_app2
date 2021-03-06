module PostsHelper
  def kind
    kind = ["自由記述", "一問一答", "一問多答", "並び替え"]
    kind.map { |s| [s, s] }.to_h
  end

  def media
    media = ["漫画（本編）", "SBS", "ビブルカード", "漫画（特別編）", "アニメ", "映画", "小説", "ゲーム"]
    media.map { |s| [s, s] }.to_h
  end

  def series
    series = ["東の海編", "アラバスタ編", "空島編", "ウォーターセブン編", "エニエス・ロビー編", "スリラーバーク編",
              "シャボンディ諸島編", "女ヶ島編", "インペルダウン編", "頂上戦争編", "魚人島編", "パンクハザード編",
              "ドレスローザ編", "ゾウ編", "ホールケーキアイランド編", "世界会議編", "ワノ国編"]
    series.map { |s| [s, s] }.to_h
  end

  def belong
    belong = ["麦わらの一味", "海軍", "世界政府", "革命軍", "四皇", "王下七武海", "最悪の世代", "麦わら大船団", "海賊"]
    belong.map { |s| [s, s] }.to_h
  end

  def group
    group = ["アーロン一味", "赤髪海賊団", "赤鞘九人男", "アルビダ海賊団", "イデオ海賊団", "ウソップ海賊団",
             "美しき海賊団", "お庭番衆", "オンエア海賊団", "侠客団", "海軍支部", "海軍本部",
             "神の軍団", "カリブー海賊団", "ガレーラカンパニー", "キッド海賊団", "巨兵海賊団",
             "金獅子海賊団", "九蛇海賊団", "クリーク海賊団", "黒炭家", "クロネコ海賊団",
             "黒ひげ海賊団", "光月家", "五老星", "猿山連合軍", "山賊", "CP-0", "CP9",
             "G-5", "G-8", "ジェルマ66", "霜月家", "シャンディア", "銃士隊", "賞金稼ぎ",
             "白ひげ海賊団", "白ひげ海賊団傘下", "新巨兵海賊団", "新魚人海賊団", "人生バラ色ライダーズ",
             "スペード海賊団", "スリラーバーク海賊団", "世界経済新聞社", "SWORD", "タイヨウの海賊団",
             "チューリップ海賊団", "天竜人", "飛び六胞", "トムズワーカーズ", "ドレーク海賊団",
             "ドンキホーテファミリー", "ニセ麦わらの一味", "ネフェルタリ家", "ノックス海賊団",
             "ハートの海賊団", "破戒僧海賊団", "八宝水軍", "バギーズデリバリー", "バルトクラブ",
             "バレルズ海賊団", "バロックワークス", "反乱軍", "百獣海賊団", "ビッグ・マム海賊団",
             "人攫い屋", "ファイアタンク海賊団", "フォクシー海賊団", "フランキー一家", "ブリキング海賊団",
             "ブルージャム海賊団", "ベラミー海賊団", "ホーキンス海賊団", "ボニー海賊団", "マクロ一味",
             "見廻り組", "ヨンタマリア大船団", "リク家", "ルンバー海賊団", "ローリング海賊団",
             "ロジャー海賊団", "ロックス海賊団"]
    group.map { |s| [s, s] }.to_h
  end

  def geography
    geography = ["アーロンパーク", "アマゾン・リリー", "アラバスタ王国", "東の海", "イリシア王国",
                 "インペルダウン", "ウイスキーピーク", "ヴィラ", "ウェザリア", "西の海",
                 "ウォーターセブン", "エニエス・ロビー", "エルバフ", "オイコット王国", "鬼ヶ島",
                 "オハラ", "オレンジの町", "花ノ国", "カマバッカ王国", "魚人島", "クライガナ島",
                 "偉大なる航路", "ゴア王国", "ゴート島", "ココヤシ村", "ゴッドバレー",
                 "コリーダコロシアム", "南の海", "サクラ王国", "サン・ファルド", "シェルズタウン",
                 "ジェルマ王国", "シモツキ村", "ジャヤ", "シャボンディ諸島", "シロップ村", "新世界",
                 "スカイピア", "スパイダーマイルズ", "スフィンクス", "スリラーバーク", "スワロー島",
                 "セント・ポプラ", "ソルベ王国", "珍獣の島", "月", "テーナ・ゲーナ王国",
                 "テキーラウルフ", "万国", "トリノ王国", "ドレスローザ", "トンタッタ王国",
                 "何もない島", "ナバロン", "ニューマリンフォード", "北の海", "ハチノス", "バテリラ",
                 "バナロ島", "バラティエ", "ハラヘッターニャ", "バルジモア", "バルティゴ",
                 "バロンターミナル", "パンクハザード", "ビルカ", "フーシャ村", "フールシャウト島",
                 "双子岬", "プッチ", "フレバンス", "プロデンス王国", "ボーイン列島", "ホールケーキアイランド",
                 "マリージョア", "マリンフォード", "ミラーボール島", "メルヴィユ", "モガロ王国", "モコモ公国",
                 "モックタウン", "ラフテル", "リヴァース・マウンテン", "リトルガーデン", "ルスカイナ",
                 "ルブニール王国", "ルルシア王国", "赤い港", "ローグタウン", "水先星島",
                 "ロングリングロングランド", "ワノ国", "悪ブラックドラム王国"]
    geography.map { |s| [s, s] }.to_h
  end

  def category
    category = ["悪魔の実", "異名", "科学兵器", "刀", "キャラクター", "口癖", "血液型", "懸賞金", "古代兵器",
                "事件", "自然現象", "種族", "植物", "身長", "数字", "SMILE", "星座", "声優", "セリフ",
                "貝", "タイトル", "戦い", "食べ物", "誕生日", "地理", "電伝虫", "道具", "動物", "年齢", "乗り物",
                "覇気", "病気", "武器", "武術", "船", "店", "名言", "文字", "役職", "呼び方", "料理", "歴史", "技", "笑い方"]
  end

  def tags
    tags = { kind: kind, media: media, series: series, belong: belong, group: group, geography: geography, category: category }
  end
end
