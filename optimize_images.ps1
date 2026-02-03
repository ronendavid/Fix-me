Add-Type -AssemblyName System.Drawing

function Convert-ToJpeg {
    param (
        [string]$inputPath,
        [string]$outputPath,
        [int]$quality = 75
    )

    if (-not (Test-Path $inputPath)) {
        Write-Host "File not found: $inputPath"
        return
    }

    $image = [System.Drawing.Image]::FromFile($inputPath)
    
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $quality)

    $image.Save($outputPath, $codec, $encoderParams)
    $image.Dispose()
    
    Write-Host "Converted $inputPath to $outputPath"
}

$imagesDir = Join-Path $PWD "images"

# Optimizing large PNGs by converting to JPEG
Convert-ToJpeg -inputPath (Join-Path $imagesDir "tip-banner.png") -outputPath (Join-Path $imagesDir "tip-banner.jpg")
Convert-ToJpeg -inputPath (Join-Path $imagesDir "fix-me_subj_image.png") -outputPath (Join-Path $imagesDir "fix-me_subj_image.jpg")
