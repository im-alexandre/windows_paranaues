# Adicionar-Neovim-MenuCompleto.ps1
# Adiciona "Abrir com Neovim" (arquivos) e "Abrir pasta no Neovim" (diretórios)
# 100% seguro, reversível e sem alterar associações de sistema

$ErrorActionPreference = 'Stop'

# 🧭 Caminho do Neovim
$nvimPath = "C:\Program Files\Neovim\bin\nvim.exe"
if (-not (Test-Path $nvimPath)) {
    Write-Error "Neovim não encontrado em '$nvimPath'. Ajuste o caminho e tente novamente."
    exit 1
}

# 🪄 Comandos de execução
$cmdFile = "pwsh.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command `"Start-Process -FilePath '$nvimPath' -ArgumentList '--', '%1' -WorkingDirectory (Split-Path '%1')`""
$cmdDir  = "pwsh.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command `"Start-Process -FilePath '$nvimPath' -ArgumentList '--', '%V' -WorkingDirectory '%V'`""

# 📂 Caminhos do registro
$baseHKCU = "HKCU:\Software\Classes"
$fileMenuKey = "$baseHKCU\*\shell\Abrir_com_Neovim"
$fileCmdKey  = "$fileMenuKey\command"
$dirMenuKey  = "$baseHKCU\Directory\shell\Abrir_pasta_no_Neovim"
$dirCmdKey   = "$dirMenuKey\command"

# 🧩 Adiciona para arquivos
New-Item -Path $fileMenuKey -Force | Out-Null
New-ItemProperty -Path $fileMenuKey -Name "Icon" -Value $nvimPath -Force | Out-Null
New-ItemProperty -Path $fileMenuKey -Name "MUIVerb" -Value "Abrir com Neovim" -Force | Out-Null
New-Item -Path $fileCmdKey -Force | Out-Null
New-ItemProperty -Path $fileCmdKey -Name "(default)" -Value $cmdFile -Force | Out-Null

# 🧱 Adiciona para diretórios
New-Item -Path $dirMenuKey -Force | Out-Null
New-ItemProperty -Path $dirMenuKey -Name "Icon" -Value $nvimPath -Force | Out-Null
New-ItemProperty -Path $dirMenuKey -Name "MUIVerb" -Value "Abrir pasta no Neovim" -Force | Out-Null
New-Item -Path $dirCmdKey -Force | Out-Null
New-ItemProperty -Path $dirCmdKey -Name "(default)" -Value $cmdDir -Force | Out-Null

Write-Host "✅ Menu de contexto atualizado com sucesso!"
Write-Host "   • 'Abrir com Neovim' → arquivos"
Write-Host "   • 'Abrir pasta no Neovim' → diretórios"
Write-Host "   Caminho usado: $nvimPath"

# 🔄 Reinicia Explorer para aplicar
taskkill /f /im explorer.exe
start explorer.exe
