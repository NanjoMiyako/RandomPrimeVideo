#SendKeysを使うため、System.Windows.Forms名前空間読込
Add-Type -AssemblyName System.Windows.Forms

$input = Read-Host "シーズンのエピソードの数を入力:"
$tabCount = $input

echo "ランダム選択開始します、エピソード番号のセレクトボックスをクリックしてください"
#この間にトップ画面をAmazon Prime Videoのシリーズ画面にする
 [Console]::Beep(294, 500)
Start-Sleep -s 30
echo "Start"
 [Console]::Beep(294, 500)

#PageDownの最大値を設定
$rndMax = $tabCount

$rnd = Get-Random -Maximum ($rndMax) -Minimum 0

if($rnd -eq 0){

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -s 1
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -s 1
exit

}

for($i=0; $i -lt $rnd; $i++){

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -s 1

}

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -s 1
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -s 1
exit
