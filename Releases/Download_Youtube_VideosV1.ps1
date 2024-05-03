#This is to run  the downloader
function down-load {
Do {
    $URL = Read-Host 'Enter URL'
} until ($URL)
yt-dlp.exe $URL
Clear-Variable url
}
# the location for the download to be put to
function Folder-location {
    if ($nul -eq $folder){
    $folder = 'Z:\My Videos\YT Stuff\YouTube_silpaeja_minecraft'
    cd $folder
    start $folder
    Write-Host 'This is the folder that will be used as the download loaction.' -ForegroundColor Green
        Write-Host $folder 'It should have opened' -ForegroundColor Red
}
        Else{Write-Host 'This is the folder that will be used as the download loaction.' -ForegroundColor Green
        Write-Host $folder -ForegroundColor Red
        }
}
#Yes no to loop will loop the start-now
function ask-user {
    do {
       $answer = Read-Host -Prompt 'Do you want to continue? (Y/N)'
       if ("YES","YE","Y" -contains $answer) {start-now}
       elseif ("NO", "N" -contains $answer) {$answer = 'false'}
    }until ($answer -eq $false) break
} # End function ask-user
function start-now {
    clear
    Write-Host 'To stop the sctip midway just use CTRL+C' -ForegroundColor Cyan
    Folder-location
    down-load
    ask-user
}
start-now