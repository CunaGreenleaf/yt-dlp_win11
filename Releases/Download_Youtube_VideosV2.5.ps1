#This will use a window to get the user to select the folder location for download
Function Get-Folder($initialDirectory= 'Z:\My Videos\YT Stuff'){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK"){
        $folder += $foldername.SelectedPath
        return $folder
        }
        else{
             do {
                $answer = Read-Host -Prompt 'Do you want to continue? (Y/N)'
                if ("YES","YE","Y" -contains $answer) {start-now}
                elseif ("NO", "N" -contains $answer) {$answer = 'false'}
                }until ($answer -eq $false) break
        }
    
}
Function Check-Folder{
    if ($null -eq $folder){
        $Global:folder = Get-Folder
        OpenFolder-location
            }else{OpenFolder-location
}
}
#This will set the Folder location and check if that folder is opened
function OpenFolder-location {
    cd $folder
    $shell = New-Object -ComObject Shell.Application
    $window = $shell.Windows() | where {$_.Document.Folder.Self.Path -ieq $folder}
        if ($null -eq $window){
            start $folder
            Write-Host 'This is the folder that will be used as the download loaction.' -ForegroundColor Green
            Write-Host $folder 'It should have opened' -ForegroundColor Red
            }
            Else{
                    Write-Host 'This is the folder that will be used as the download loaction. It is opened somewere.' -ForegroundColor Green
                    Write-Host $folder -ForegroundColor Red
                    }
}
#This is to run  the downloader
function down-load {
Do {
    $URL = Read-Host 'Enter URL'
} until ($URL)
yt-dlp.exe $URL
Clear-Variable url
}
# the location for the download to be put to
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
    Check-Folder
    down-load
    ask-user
}
start-now