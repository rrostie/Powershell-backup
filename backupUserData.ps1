<#
.Synopsis
   Creates folder structure at the target backup location and copies Desktop, Documents and Favorities from User's profile

.DESCRIPTION
   Takes a target variable targetFolder, to be the parent backup location. Feel free to modify as needed. 
   Creates folder structure under targetFolder in YYYY_MMM_DD_HH.MM format and creates Desktop, Documents and Favorities folders
   All files are copied under their respective folders in exact folder structure. 
   
    Script by         : Ketan Thakkar (KetanBhut@live.com)
    Script version    : 1.0
    Release date      : 17-Mar-2018
    Disclaimer        : This script is tested and working in my environment, 
                        it is recommended that you test it in a test environment 
                        before using in your production environment
#>

# Target path. $TargetFolder can be modified to be the backup location. 
$targetFolder = "E:\Code\powershell\my\2018\mar\scriptRequests\TargetFolder"
$date = Get-Date
$targetSubFolder = $date.Year.ToString() +'_'+[cultureinfo]::InvariantCulture.DateTimeFormat.GetAbbreviatedMonthName($date.Month) + '_'+ $date.Day.ToString() + '_'+$date.Hour.ToString()+ '.'+$date.Minute.ToString()
$finalBackupPath = $targetFolder + '\'+$targetSubFolder

# Create the path for today's date/time. warn if already exists
if(Test-Path $finalBackupPath)
{
    Write-Warning "Target path for the date and time already exists, do you want to continue?"
    $sayYes = Read-Host "..or exit here? Press 'Y' or 'y' for 'Yes', else press any key"
    if($sayYes -eq 'y' -or $sayYes -eq 'Y') {}
    else { Write-Warning "Existing..." -fore DarkYellow; exit}
}
else
{
    New-Item -Type Directory -Path $finalBackupPath -Force |Out-Null
}

# Create Target Documents, Desktop and Favorites folder
New-Item -Type Directory -Path ($finalBackupPath + '\Documents') -Force |Out-Null
New-Item -Type Directory -Path ($finalBackupPath + '\Desktop') -Force |Out-Null
New-Item -Type Directory -Path ($finalBackupPath + '\Favorites') -Force |Out-Null

Get-ChildItem -Path $home\Favorites | Copy-Item -Destination ($finalBackupPath + '\Favorites') -Recurse -Container
Write-Verbose "Favorites copied...." 


Get-ChildItem -Path $home\Desktop | Copy-Item -Destination ($finalBackupPath + '\Desktop') -Recurse -Container
Write-Verbose "Desktop copied...." 


Get-ChildItem -Path $home\Documents | Copy-Item -Destination ($finalBackupPath + '\Documents') -Recurse -Container
Write-Verbose "Documents copied...." 


# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU3jc/Jvaky5ZliOoCbzbH1qSa
# O76gggI9MIICOTCCAaagAwIBAgIQajFgfCU8VJdF2/dCo6QXeTAJBgUrDgMCHQUA
# MCwxKjAoBgNVBAMTIVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0xNzAzMDYwMzI3MDhaFw0zOTEyMzEyMzU5NTlaMBoxGDAWBgNVBAMTD1Bvd2Vy
# U2hlbGwgVXNlcjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAqh86EKUJEIk0
# oUtWT5M0cpdBaE9yiBWDI/hdjOMj7bdT+XbYVYCP2nQbX+4VUjFoBsLJxwzvfxHi
# GTea5XawKnCNN8ct5V52ULZsUzfExZWYz301SXdH6qJ0y6PoZ/dyODGIFM6IC6JP
# J+tQH573k2rgUpVMwfH8eLNXjhV5e68CAwEAAaN2MHQwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwXQYDVR0BBFYwVIAQJNEbzBqCPNlAawSvZnKQ5aEuMCwxKjAoBgNVBAMT
# IVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdIIQqzRtkF0R7o1AHdn+
# au6T3zAJBgUrDgMCHQUAA4GBAIB6yikrv914JNfDe9WgxvSDFhlWk5qEVps1X2zK
# tOH7bH+r9LgtSl1Sqso/HFGG7kEZWiEWTwQGE4It1ThYA4/jiKiRzspo7Et2FFCZ
# V5mGKR7HW22CzFJKA4EwP+kxU0NLhOgl+8+iamTaA9VqXCwAqEQSGO3mjpbNuAup
# HF5IMYIBYDCCAVwCAQEwQDAsMSowKAYDVQQDEyFQb3dlclNoZWxsIExvY2FsIENl
# cnRpZmljYXRlIFJvb3QCEGoxYHwlPFSXRdv3QqOkF3kwCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FNuFg6z64FtynNwytCr9/xh9btGYMA0GCSqGSIb3DQEBAQUABIGAeGKloCGgmlxc
# A+2sN+z5T21S/eXl7S89buxn8Fh6GgaPS6auAIxTCifPUkk+RKkpLiAHWHfCQDWU
# jVVE62wQsafc4h+o4RRpEKZ9kJotOc+uPA5Dbf7T3fBXMYe2f7qqjJ4Xy0KCtYcq
# dMNJ521WJIyUVGenoGawhZXYn/M5yYM=
# SIG # End signature block
