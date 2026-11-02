# 在桌面创建一个带院徽的快捷方式
# 由「创建桌面图标.bat」调用；单独双击本文件也能用。

$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
if (-not $root) { $root = Split-Path -Parent $MyInvocation.MyCommand.Path }

$html = Join-Path $root '实验室管理.html'
$ico  = Join-Path $root '实验室图标.ico'

Write-Host ''
Write-Host '==========================================' -ForegroundColor Cyan
Write-Host '  创建桌面图标' -ForegroundColor Cyan
Write-Host '==========================================' -ForegroundColor Cyan
Write-Host ''

if (-not (Test-Path $html)) {
    Write-Host '  [错误] 没有找到 实验室管理.html' -ForegroundColor Red
    Write-Host '         请把这个脚本和 实验室管理.html 放在同一个文件夹里。'
    Write-Host ''
    exit 1
}

$desktop = [Environment]::GetFolderPath('Desktop')
if (-not $desktop -or -not (Test-Path $desktop)) {
    Write-Host '  [错误] 找不到桌面文件夹。' -ForegroundColor Red
    exit 1
}

$lnkPath = Join-Path $desktop '实验室管理系统.lnk'

$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut($lnkPath)
$sc.TargetPath       = $html
$sc.WorkingDirectory = $root
$sc.Description      = '人工智能与软件学院实验室管理系统'
$sc.IconLocation     = if (Test-Path $ico) { "$ico,0" } else { "$html,0" }
$sc.Save()

Write-Host ('  已创建桌面图标：' + $lnkPath) -ForegroundColor Green
Write-Host ''
if (Test-Path $ico) {
    Write-Host '  图标用的是这个文件夹里的「实验室图标.ico」（院徽）。' -ForegroundColor Green
} else {
    Write-Host '  没找到 实验室图标.ico，快捷方式会用浏览器图标。' -ForegroundColor Yellow
}
Write-Host ''
Write-Host '  现在去桌面看看，应该有一个叫「实验室管理系统」的图标。'
Write-Host '  双击它就能打开程序。'
Write-Host ''
Write-Host '  提示：这只是个快捷方式，删掉它不影响程序本身；'
Write-Host '        以后如果移动了文件夹位置，重新运行一次本脚本即可。'
Write-Host ''
