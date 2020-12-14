#!/bin/bash
MY_DIRNAME=$(dirname $0)
cd $MY_DIRNAME


echo "最終更新20201123 現在macのみ対応しています。"
echo 初回環境構築に15〜20分ほど時間がかかります。
echo ネットの安定している環境でインストールしてください。
echo 初回環境構築でインストールされるのは以下の４つです。
echo brew / wget / ffmpeg / youtube-dl
echo 足りないもののみインストールされます。
echo -n "続行しますか？（y/n）:" # 改行しないようにオプション
read ANS

case $ANS in
  [Yy]* )
  # 引数（ひきすう）の先頭がY,yだった場合 ワイルドカード使用

      echo brew:
      brew -v &> /dev/null
      if [ $? -ne 0 ] ; then
        echo 未インストール
        echo インストール開始
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

      else
        echo インストール済み
      fi 

      echo wget:
      wget --version &> /dev/null
      if [ $? -ne 0 ] ; then
        echo 未インストール
        echo インストール開始
        brew install wget
  
      else
        echo インストール済み
      fi

      echo ffmpeg:
      ffmpeg -version &> /dev/null
      if [ $? -ne 0 ] ; then
        echo 未インストール
        echo インストール開始
        brew install ffmpeg
      else
        echo インストール済み
      fi

      echo youtube-dl:
      youtube-dl --version &> /dev/null
      if [ $? -ne 0 ] ; then
        echo 未インストール
        echo インストール開始
        brew install youtube-dl
      else
        echo インストール済み
      fi


      ;;
    *)
      echo "Noが選択されました。" #通常はエラーメッセージ
      ;;
esac                                          # case文の終了


echo -n "youtube-dlをアップデートしますか？（y/n）:"
read ANS
case $ANS in
  [Yy]* )
    echo "sudo で実行します。"
    sudo youtube-dl -U
    ;;
  *)
    ;; # リストの終了
esac   # case文の終了



#youtube-dl --list-format $str

while :
do 
echo +-------------------------------------+
echo  "URLを入力してください(終了するには'n'を入力)"
echo +-------------------------------------+
read str 
if [ $str = n ]; then 
   echo "'n'が入力されました。終了します。" 
   break 
   exit
else 
   echo "DLを開始します。"
fi



youtube-dl --format 137+140 --merge-output-format mp4 $str 
if [ $? -ne 0 ] ; then
  echo DLに失敗しました。
  echo 画質を854x480に変更して再DLします。
  youtube-dl --format 135+140 --merge-output-format mp4 $str
  if [ $? -ne 0 ] ; then
  echo DLに失敗しました。
  echo 動画情報を表示します。問題解決のヒントにしてください。
  youtube-dl --list-format $str
  fi
else
  echo DL完了
fi

#echo -n "別の動画もダウンロードしますか？(y/n):"
#read ANS
#case "$ANS" in [yY]*) ;; *) break ; exit ;; esac
done

exit 0




