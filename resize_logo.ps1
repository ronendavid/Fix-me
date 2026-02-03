Add-Type -AssemblyName System.Drawing

$inputPath = Join-Path $PWD "images/fix-me_logo.png"
$outputPath = Join-Path $PWD "images/fix-me_logo_optimized.png"
$targetWidth = 360

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    exit
}

$image = [System.Drawing.Image]::FromFile($inputPath)
$aspectRatio = $image.Height / $image.Width
$targetHeight = [int]($targetWidth * $aspectRatio)

$destImage = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
$graphics = [System.Drawing.Graphics]::FromImage($destImage)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$graphics.DrawImage($image, 0, 0, $targetWidth, $targetHeight)

$destImage.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$image.Dispose()
$destImage.Dispose()
$graphics.Dispose()

Write-Host "Resized logo to ${targetWidth}px width at $outputPath"