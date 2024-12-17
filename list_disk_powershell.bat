$folders = Get-ChildItem -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object { $size = (Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { !$_.PSIsContainer } | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum / 1GB; [PSCustomObject]@{Folder=$_.FullName; SizeGB=[math]::Round($size, 2)} }; $folders | Sort-Object -Property SizeGB -Descending | Format-Table -AutoSize; $totalSize = ($folders | Measure-Object -Property SizeGB -Sum).Sum; Write-Output "`nTotal Size (GB): $([math]::Round($totalSize, 2))"
