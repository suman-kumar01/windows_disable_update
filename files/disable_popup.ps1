# This snippet is to add the deny execute permissions to the pop-up executables
# Windows Updates wuapp.exe (GUI) & PSWindowsUpdate (PS Module) are unaffected. To reverse, simply remove the added ACL
 
$system32="$env:windir\System32"
$annoyingNotifications="$system32\musnotification.exe","$system32\musnotificationux.exe"
$denyExecute= New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","Execute","Deny")
$annoyingNotifications|%{
    takeown /f $_;
if (test-path $_){    
$acl = Get-ACL $_   
    $acl.AddAccessRule($denyExecute)
    Set-Acl $_ $acl
}
    }