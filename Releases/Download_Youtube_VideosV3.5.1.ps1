Function Sing-Bat {
# Load the necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Question"
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = "CenterScreen"

# Create a label to display the question
$label = New-Object System.Windows.Forms.Label
$label.Text = "What type of download?"
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($label)

$yesButton = New-Object System.Windows.Forms.Button
$yesButton.Text = "Single"
$yesButton.Size = New-Object System.Drawing.Size(75, 23)
$yesButton.Location = New-Object System.Drawing.Point(50, 60)
$yesButton.Add_Click({
    $form.Tag = 'Single'
    $form.Close()
})
$form.Controls.Add($yesButton)

$noButton = New-Object System.Windows.Forms.Button
$noButton.Text = "Batch"
$noButton.Size = New-Object System.Drawing.Size(75, 23)
$noButton.Location = New-Object System.Drawing.Point(150, 60)
$noButton.Add_Click({
    $form.Tag = 'Batch'
    $form.Close()
})
$form.Controls.Add($noButton)

# Show the form
$form.ShowDialog()
if ($form.Tag -eq 'single') {
    sing-Check-Folder
    sing-download
    ask-user
    }
        
    else {
    Bat-SelectArtests
    Bat-download
    ask-user
}
}


Function sing-GetFolder($initialDirectory= 'Z:\My Videos\YT Stuff'){
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
                if ("YES","YE","Y" -contains $answer) {sing-bat}
                elseif ("NO", "N" -contains $answer) {$answer = 'false'}
                }until ($answer -eq $false) break
        }
    
}
Function sing-Check-Folder{
    if ($null -eq $folder){
        $Global:folder = sing-GetFolder
        sing-OpenFolderlocation
            }else{sing-OpenFolderlocation
}
}
function sing-OpenFolderlocation {
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
function sing-download {
Do {
    $URL = Read-Host 'Enter URL'
} until ($URL)
yt-dlp.exe $URL
Clear-Variable url
}


Function Bat-SelectArtests{

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Select Artests"
$form.Size = New-Object System.Drawing.Size(300,400)
$form.StartPosition = "CenterScreen"

# Create a label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select Artests to Download:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,10)
$form.Controls.Add($label)

# Create a CheckedListBox
$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Size = New-Object System.Drawing.Size(260, 250)
$checkedListBox.Location = New-Object System.Drawing.Point(10,40)
$form.Controls.Add($checkedListBox)

# Populate the CheckedListBox with folders from C drive
$folders = @(Get-ChildItem -Name "Z:\My Videos\YT Stuff\Manhwa Recaps"| Sort-Object)
foreach ($folder in $folders) {
    $checkedListBox.Items.Add($folder)
}


# Create an OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Location = New-Object System.Drawing.Point(50, 310)
$okButton.Add_Click({
    $selectedFolders = @()
    foreach ($index in $checkedListBox.CheckedIndices) {
        $selectedFolders += $checkedListBox.Items[$index]
    }
    $form.Tag = $selectedFolders
    $form.Close()
})
$form.Controls.Add($okButton)

# Create a Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Location = New-Object System.Drawing.Point(150, 310)
$cancelButton.Add_Click({
    $form.Tag = $null
    $form.Close()
})
$form.Controls.Add($cancelButton)

# Show the form
$form.ShowDialog()
$Global:selectedArtests = @()
# Output the selected folders
if ($form.Tag -ne $null) {
    
    ForEach ($Selected in $form.Tag) {
        $Global:selectedArtests += $Selected
    }
        
} else {
    Write-Output "No folders selected."
}
}
Function Bat-download {
$Global:selectedArtests
foreach ($thing in $Global:selectedArtests) {
    $folderPath = 'Z:\My Videos\YT Stuff\Manhwa Recaps\' + $thing
    CD $folderPath
    Write-Host Working on Downloading from $thing -ForegroundColor Green
    Write-Host Download location $folderPath  -ForegroundColor yellow
    Do {
    $URL = 'https://www.youtube.com/@' + $thing + '/videos'
        } until ($URL)
        yt-dlp.exe $URL
        Clear-Variable url
        cd..
        }
}


function ask-user {
    do {
       $answer = Read-Host -Prompt 'Do you want to continue? (Y/N)'
       if ("YES","YE","Y" -contains $answer) {Sing-Bat}
       elseif ("NO", "N" -contains $answer) {$answer = 'false'}
    }until ($answer -eq $false) break
}

Sing-Bat