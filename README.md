Download YT vids from Win11

# yt-dlp_win11
> A simple user interface for the windows X86  version of  ty-dlp.

## Release History

* 2.5.0
    * ADD: Function Get-Folder will not default to Desktop if the browse for folder option is closed or canceled. 
* 2.0.0
    * ADD: Interactive folder selector with network storage access.
    * ADD: check for folder if opened.  

* 1.0.0
    * First PS1 iteration.



## How to use

1. Download the newest WINx86 release. [yt-dlp_X86][yt-dlp_X86]  
2. Make a folder in any location you like. I used C:\yt-dlp  as to make scripting easier.
   - The yt-dlp and one of my [Download_Youtube_Videos.PS1][Rleases] Versions.
   
![CFolder]

3. Open the advanced systems settings and select environment variables. Then inside of the system variables edit the PATH options.
  
![ADVEVO]

   - Select new and add the full folder path of the yt-dlp location and save.
  
![PathAdd]

4. The batch file. You will have to change the file location name of the PS1 to the file path you have. And again, this is made for windows 11. Save the batch to the Desktop.

![BthFile]

5. Now just open the newly made .bat file. 
   - An interactive folder selector will popup. Select your folder you want the stuff to download to and click OK.

![BatSelecter]

6. Follow the promt and have fun.

>[!WARNING]
> - for V2.0-V2.5 You will have to change the 'Z:\My Videos\YT Stuff' in the  `Function Get-Folder($initialDirectory= 'Z:\My Videos\YT Stuff')` to the folder you want it to start in.
> - For V1 `$folder = 'Z:\My Videos\YT Stuff\YouTube_silpaeja_minecraft'` will need to be changed to the folder of choice. If you only want to have a single folder for all output downloads and then you may move the downloads to your archive of choice.

> [!NOTE]
> - You may have multiple iterations opened as the same time going to diffrent folders. Just remind that the download speed will be shared with each instiance that is opened.

[(Back to top)](#yt-dlp_win11)

<!-- Markdown link & img dfn's -->
[Parsiteytdlp]: https://github.com/yt-dlp/yt-dlp
[yt-dlp_X86]: https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_x86.exe
[CFolder]: https://github.com/CunaGreenleaf/yt-dlp_win11/blob/main/How%20to%20use/Photos/Screenshot%202024-03-20%20162328.png
[ADVEVO]: https://github.com/CunaGreenleaf/yt-dlp_win11/blob/main/How%20to%20use/Photos/Screenshot%202024-03-20%20162810.png
[PathAdd]: https://github.com/CunaGreenleaf/yt-dlp_win11/blob/main/How%20to%20use/Photos/Screenshot%202024-03-20%20163221.png
[BthFile]: https://github.com/CunaGreenleaf/yt-dlp_win11/blob/main/How%20to%20use/Photos/Screenshot%202024-03-20%20164449.png
[BatSelecter]: https://github.com/CunaGreenleaf/yt-dlp_win11/blob/main/How%20to%20use/Photos/Screenshot%202024-05-03%20131654.png
[Rleases]: https://github.com/CunaGreenleaf/yt-dlp_win11/tree/main/Releases
