$code = @'
    [DllImport("user32.dll")]
     public static extern IntPtr GetForegroundWindow();
'@

Add-Type $code -Name Utils -Namespace Win32

while(1){
    $Script:hwnd = [Win32.Utils]::GetForegroundWindow()
    Get-Process | 
        Where-Object { $_.mainWindowHandle -eq $hwnd } | 
        Select-Object processName, MainWindowTItle, MainWindowHandle,Id
    sleep -Milliseconds 200
}

$Script:hwnd = [Win32.Utils]::GetForegroundWindow()
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 2)# Minimize window