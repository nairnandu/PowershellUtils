#Bing wallpaper images are named with current date
$target = Get-Date -Format "yyyyMMdd"
$filename = $target + ".jpg"
#Bing desktop wallpaper images folder - source location
$source = "C:\users\" + $env:username + "\AppData\Local\Microsoft\BingWallpaperApp\WPImages\"
#Teams background images folder - destination
$destination = "C:\Users\"+ $env:username +"\AppData\Roaming\Microsoft\Teams\Backgrounds\Uploads\"
#Copy
Copy-Item $source$filename -Destination $destination -Force