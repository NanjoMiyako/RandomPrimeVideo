#SendKeysを使うため、System.Windows.Forms名前空間読込
Add-Type -AssemblyName System.Windows.Forms

$input = [int](Read-Host "シーズンのエピソードの数を入力:")
$tabCount = $input

$playTime = [int](Read-Host "一話毎の収録分数を入力:")

#1236,343
$NarabeKaeX = [int](Read-Host "「並べ替え」ボタンのX座標を入力(ex:1236):")
$NarabeKaeY = [int](Read-Host "「並べ替え」ボタンのY座標を入力(ex:343):")

#1303, 139
#$PlayerCloseX = [int](Read-Host "「プレーヤーを閉じる」ボタンのX座標を入力(ex:1303):")
#$PlayerCloseY = [int](Read-Host "「プレーヤーを閉じる」ボタンのY座標を入力(ex:139):")



# 座標
$x = $NarabeKaeX
$y = $NarabeKaeY

# .NET Frameworkの宣言
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

# Windows APIの宣言
$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto,CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru

Write-Host "画面をプライムビデオシリーズのトップに設定してください"
Start-Sleep -s 15


$firstFlg = $true

While($true){

    # Ctrl+Homeで予めページの一番上に移動する
    [System.Windows.Forms.SendKeys]::SendWait("^{HOME}")
    Start-Sleep -s 3
    
    # PageDownで予めページを下にずらす
    [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
    Start-Sleep -s 3

    # マウスカーソル移動
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($NarabeKaeX, $NarabeKaeY)

    # 左クリック
    $SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);


    #PageDownの最大値を設定
    $rndMax = $tabCount-1

    $rnd = Get-Random -Maximum ($rndMax) -Minimum 0

    if($rnd -eq 0){
    
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        Start-Sleep -s 1
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        Start-Sleep -s 1

        if($firstFlg -eq $false){
            #[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
            Start-Sleep -s 1
        }

        $sleepTime = $playTime * 60

        Start-Sleep -s $sleepTime

        continue        

    }

    for($i=0; $i -lt $rnd; $i++){

        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        #[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        Start-Sleep -s 1

    }

    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    Start-Sleep -s 1
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -s 1

    if($firstFlg -eq $false){
        #[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        Start-Sleep -s 1
    }


    $sleepTime = $playTime * 60

    Start-Sleep -s $sleepTime
    
    [System.Windows.Forms.SendKeys]::SendWait("{F5}")

    Start-Sleep -s 10

    #プレーヤーを閉じて前画面に移動
    # マウスカーソル移動
    #[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($PlayerCloseX, $PlayerCloseY)

    # 左クリック
    #$SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
    #$SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);

    if($firstFlg -eq $true){
        $firstFlg = $false
    }else{
    }

}
