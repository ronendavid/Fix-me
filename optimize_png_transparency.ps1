Add-Type -AssemblyName System.Drawing

$inputPath = Join-Path $PWD "images/fix-me_subj_image.png"
$outputPath = Join-Path $PWD "images/fix-me_subj_image_optimized.png"
$targetWidth = 800

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    exit
}

$image = [System.Drawing.Image]::FromFile($inputPath)
$aspectRatio = $image.Height / $image.Width
$targetHeight = [int]($targetWidth * $aspectRatio)

# Create a new bitmap with the new dimensions
$destImage = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
$graphics = [System.Drawing.Graphics]::FromImage($destImage)

# High quality settings for resizing
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

# Preserve transparency
$graphics.Clear([System.Drawing.Color]::Transparent)

# Draw the resized image
$graphics.DrawImage($image, 0, 0, $targetWidth, $targetHeight)

# Save as PNG
$destImage.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$image.Dispose()
$destImage.Dispose()
$graphics.Dispose()

Write-Host "Optimized PNG saved to $outputPath"