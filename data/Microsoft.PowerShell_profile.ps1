oh-my-posh init pwsh --config "$HOME\AppData\Local\Programs\oh-my-posh\themes\night-owl_2.omp.json" | Invoke-Expression
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
