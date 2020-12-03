<#
Script to jiggle mouse and keep screen alive until 5pm. 
Written By: iNet (Alan Newingham)
Date: 06/26/2020
/#>

#Adding Windows Forms Controls as that is what we need to tie into to move the mouse later. 
Add-Type -AssemblyName System.Windows.Forms

# Alans Make PowerShell Disappear - Snippet
$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$asyncwindow = Add-Type -MemberDefinition $windowcode -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0)

#While Loop Work 
while ($hour -le 17)
{
	#Use Windows Forms to get the position of the Cursor, and store it in a variable $Pos
	$Pos = [System.Windows.Forms.Cursor]::Position
	#Reset current mouse location
	$x = ($pos.X % 500) + 1
	$y = ($pos.Y % 500) + 1
	#Apply New Position for mouse
  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
  #Wait 10 seconds
  Start-Sleep -Seconds 10
  #Check to see what time it is. (Hour)
  $hour = (get-date).hour
}

exit
