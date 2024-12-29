
Function Select-Artests{

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

Function down-load {
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
    Select-Artests
    
    Write-Host 'To stop the sctip midway just use CTRL+C' -ForegroundColor Cyan
    down-load
    ask-user
}
start-now