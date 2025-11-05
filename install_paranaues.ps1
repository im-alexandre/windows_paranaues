# Exemplo: ln -sf target link
function mklink {
  param (
    $link,
    $target
  )
if (Test-Path $link) { Remove-Item $link -Force }
New-Item -ItemType SymbolicLink -Path $link -Target $target
}

$link = "C:\Users\imale\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$target   = Join-Path $PSScriptRoot "./terminal_settings.json"
mklink $link $target


$link = $PROFILE
$target   = Join-Path $PSScriptRoot "./profile.ps1"
mklink $link $target

# Executa um script que está no mesmo diretório
& "$PSScriptRoot\menu_open_neovim.ps1"

