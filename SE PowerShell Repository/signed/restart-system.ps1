<#
    .SYNOPSIS
        Forces a system restart
 
    .DESCRIPTION
        Execution of this script forces an system restart after 10 seconds.

    .PARAMETER Comment 
        Comment for the restart, default is "Neustart über die Aufgabenplanung".

    .PARAMETER reason 
        Reason for the system restart, default "P".

    .PARAMETER major 
        Specifies the major reason number (a positive integer, less than 256), default is 0.

    .PARAMETER minor 
        Specifies the minor reason number (a positive integer, less than 65536), default is 0.

    .PARAMETER Time 
        Time before the restart should occur, default is 10 seconds.
        
    .NOTES
        Author  : Server-Eye
        Version : 1.0

    .Link
        https://docs.microsoft.com/de-de/windows-server/administration/windows-commands/shutdown

        Reasons, major and minor settings:
        https://servereye.freshdesk.com/a/solutions/articles/14000128892
#>

[CmdletBinding()]
Param(
    [parameter(Mandatory = $false, HelpMessage = "Comment for the restart ")]
    [string]
    $Comment = "Neustart über die Aufgabenplanung",
    [parameter(Mandatory = $false, HelpMessage = "Reason for the system restart")]
    [ValidateSet("P", "U")]
    [string]
    $reason = "P",
    [parameter(Mandatory = $false, HelpMessage = "Specifies the major reason number (a positive integer, less than 256)")]
    [Int]
    $major = 0,
    [parameter(Mandatory = $false, HelpMessage = "Specifies the minor reason number (a positive integer, less than 65536)")]
    [Int]
    $minor = 0,
    [parameter(Mandatory = $false, HelpMessage = "Time before the restart should occur, default 10 seconds.")]
    [Int]
    $Time = 10
)
 
Begin {
    $FileToRunpath = "C:\WINDOWS\system32\shutdown.exe"
    Write-Host "Script started"
    $ExitCode = 0   
    $argument = '/r /t {0} /c "{1}" /d {2}:{3}:{4}' -f $Time, $Comment, $reason, $major, $minor
    #region Arguments
    $startProcessParams = @{
        FilePath     = $FileToRunpath
        ArgumentList = $argument       
        NoNewWindow  = $true
    }
    # 0 = everything is ok
}


 
Process {
    try {
        Write-Host "Trigger system restart with Arguments: $($startProcessParams.ArgumentList)"
        Start-Process @startProcessParams
 
    }
    catch {
        Write-Host "Something went wrong"
        Write-Host $_ # This prints the actual error
        $ExitCode = 1 
        # if something goes wrong set the exitcode to something else then 0
        # this way we know that there was an error during execution
    }
}
 
End {
    Write-Host "Script ended"
    exit $ExitCode
}
# SIG # Begin signature block
# MIIlMgYJKoZIhvcNAQcCoIIlIzCCJR8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU1/u2EefSqH0MZMwAjMkbLj2F
# +Buggh8aMIIFQDCCBCigAwIBAgIQPoouYh6JSKCXNBstwZR1fDANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJDAi
# BgNVBAMTG1NlY3RpZ28gUlNBIENvZGUgU2lnbmluZyBDQTAeFw0yMTAzMTUwMDAw
# MDBaFw0yMzAzMTUyMzU5NTlaMIGnMQswCQYDVQQGEwJERTEOMAwGA1UEEQwFNjY1
# NzExETAPBgNVBAgMCFNhYXJsYW5kMRIwEAYDVQQHDAlFcHBlbGJvcm4xGTAXBgNV
# BAkMEEtvc3NtYW5zdHJhc3NlIDcxIjAgBgNVBAoMGUtyw6RtZXIgSVQgU29sdXRp
# b25zIEdtYkgxIjAgBgNVBAMMGUtyw6RtZXIgSVQgU29sdXRpb25zIEdtYkgwggEi
# MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD2ffa5PXcN75tpZewrLUVUmNWe
# GUKMJu49HDdY2hbChjEf3557YCC8Ch6z+JwH1Qw+X52mUFvVOxgiQXXSzVjT4kSf
# zBkW0id0tVhwSWGys8fral5roP5P2MGDYxusC1fsCwjjBWsWtsJBT3IHSI0RfZhO
# QU/NUIAdIqd9gB90wPQ2Bl/xJUosNN6kKTc95NZsL7br/qXK+rz+HP2b9FDJSnCo
# YXmlZQznNabuJmHKkgylu/QsGy5UeDLRH5HIESeb4TYVz2FK8dkNdTANY0LaKazP
# X5APMcevI8TL76CSVtzr3G5zVP6G7zCigjXsf+r0J+cq3X1nV+SBc9N0DTQhAgMB
# AAGjggGQMIIBjDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNV
# HQ4EFgQUv6NoXcU4+16wIL34u0CFr2BkBXswDgYDVR0PAQH/BAQDAgeAMAwGA1Ud
# EwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQ
# MEoGA1UdIARDMEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBz
# Oi8vc2VjdGlnby5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJo
# dHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNy
# bDBzBggrBgEFBQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGln
# by5jb20vU2VjdGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdo
# dHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAKiH0uKG9
# MA1QtQkFdKpaP5pzussbm2FbgmwZiMeimTPKRNjmXm1XFYdbfNp6mHZrpRR7PO/B
# d+YgotlZbPHkzYa6bTSxqfiUwA+W4VdcfaGww9Nk7KoEsrJjKKmr9LD/LyCXbB7k
# f9dsM8vRw7fIp77x1owXiGvGKu263qEnqZwD5/fZbdKtkGAlhxnn+7o96UUjMg/h
# 3n9MxEUXArjkWSafpiQ3LUkcDEPDM1pTaYNaBjOKkKp7SFRA0XbnoBjuSBdZ9w7c
# f5UqIdlli/tTzvGjbJq70CuF8OktlRFmbwIqbvTHQrp8rNOcB0ZBtkAkoAmOEv2d
# o7MC2wPQExjMSTCCBd4wggPGoAMCAQICEAH9bTD8o8pRqBu8ZA41Ay0wDQYJKoZI
# hvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQw
# EgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
# b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
# aXR5MB4XDTEwMDIwMTAwMDAwMFoXDTM4MDExODIzNTk1OVowgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEe
# MBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1
# c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQktZAnc
# zomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9Ds
# FiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuG
# FFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9X
# Wrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeU
# vlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP
# 8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS
# 2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53M
# W4LTTLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0Ff
# QKlERPSZ51eHnlAfV1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLe
# vni3/GcV4clXhB4PY9bpYrrWX1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8C
# AwEAAaNCMEAwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKyA2bLMA4GA1UdDwEB
# /wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBDAUAA4ICAQBc1HwN
# z/cBfUGZZQxzxVKfy/jPmQZ/G9pDFZ+eAlVXlhTxUjwnh5Qo7R86ATeidvxTUMCE
# m8ZrTrqMIU+ijlVikfNpFdi8iOPEqgv976jpS1UqBiBtVXgpGe5fMFxLJBFV/ySa
# bl4qK+4LTZ9/9wE4lBSVQwcJ+2Cp7hyrEoygml6nmGpZbYs/CPvI0UWvGBVkkBIP
# cyguxeIkTvxY7PD0Rf4is+svjtLZRWEFwZdvqHZyj4uMNq+/DQXOcY3mpm8fbKZx
# YsXY0INyDPFnEYkMnBNMcjTfvNVx36px3eG5bIw8El1l2r1XErZDa//l3k1mEVHP
# ma7sF7bocZGM3kn+3TVxohUnlBzPYeMmu2+jZyUhXebdHQsuaBs7gq/sg2eF1JhR
# dLG5mYCJ/394GVx5SmAukkCuTDcqLMnHYsgOXfc2W8rgJSUBtN0aB5x3AD/Q3NXs
# PdT6uz/MhdZvf6kt37kC9/WXmrU12sNnsIdKqSieI47/XCdr4bBP8wfuAC7UWYfL
# UkGV6vRH1+5kQVV8jVkCld1incK57loodISlm7eQxwwH3/WJNnQy1ijBsLAL4JxM
# wxzW/ONptUdGgS+igqvTY0RwxI3/LTO6rY97tXCIrj4Zz0Ao2PzIkLtdmSL1UuZY
# xR+IMUPuiB3Xxo48Q2odpxjefT0W8WL5ypCo/TCCBfUwggPdoAMCAQICEB2iSDBv
# myYY0ILgln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMV
# VGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENl
# cnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIz
# NTk1OVowfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
# cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQw
# IgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilA
# hlRGdDFixRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6
# DBmJqGx7rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpy
# vjg7Y96Pv25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52B
# xHJAteJf7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G
# 2flGHNyMfHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIB
# YDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6
# qFM6MdWKvsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgw
# BgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5j
# b20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYB
# BQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20v
# VVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9v
# Y3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNve
# aiqMm/EAAB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS
# 9At3WpwqQTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3
# ZLCmI2pZaFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1
# fqW4w2y1z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6f
# ICUQDRn7UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIe
# Q3pFMcGcTanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lk
# uk/xYpMoJVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9
# V1DSyt39ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoK
# C6W59J7umDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLj
# tXX4oemOCiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1q
# V3AcPKRYLqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2
# p3gtuTANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5l
# dyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNF
# UlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNh
# dGlvbiBBdXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9
# MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMT
# HFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUA
# A4ICDwAwggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoE
# pc5Hg7XrxMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0
# RirNxFrJ29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48Ray
# cNOjxN+zxXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSv
# f4DP0REKV4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSi
# nL0m/9NTIMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1
# r5a+2kxgzKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5F
# GjpvzdeE8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcs
# dxkrk5WYnJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm
# /31X2xJ2+opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhA
# V3PwcaP7Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwID
# AQABo4IBWjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYD
# VR0OBBYEFBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNV
# HRMBAf8ECDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgw
# BgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5j
# b20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYB
# BQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20v
# VVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9v
# Y3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOB
# kXXfA3oyCy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+Lk
# VvlYQc/xQuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+w
# QxAPjeT5OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5Sb
# sdyybUFtZ83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKB
# c2NeoLvY3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdah
# c1cFaJqnyTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M
# 3kg9mzSWmglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0
# PHmLXGTMze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6x
# uKBlKjTg3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrx
# py/Pt/360KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinu
# tFoAsYyr4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2f
# OkiDjWswDQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
# ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2Vj
# dGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5n
# IENBMB4XDTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYT
# AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
# cmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBS
# U0EgVGltZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4IC
# DwAwggIKAoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkb
# JUzq70DWmn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxe
# TpOHuJreTAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqC
# IDq37+fWuCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhg
# iu/xrM2HYxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlR
# x06mnSlv53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSv
# RByWgiKVKoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF
# 9/gjXcRXyCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QG
# E2Ru6eEVYFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmV
# N29OfxzGPATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2
# xIPugr4srjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQAB
# o4IBeDCCAXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0O
# BBYEFGl1N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMB
# Af8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYB
# BAGyMQECAQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BT
# MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
# b1JTQVRpbWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUH
# MAKGM2h0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGlu
# Z0NBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJ
# KoZIhvcNAQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVe
# O+E5xFu66ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6K
# vaca9QIVy0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4T
# kxlVjwmQLt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6
# adt1pD55aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUc
# FubA1X9oGsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqj
# QDAXsCkWmcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4Qc
# TesNtbiGoDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx
# 6hkbgFT6R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3H
# M5mCN0TUJikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8
# nTfkKgbWw/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/f
# MYIFgjCCBX4CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECED6K
# LmIeiUiglzQbLcGUdXwwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKA
# AKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFLbmhFp7MkmOjeO6HrZ6CxeS
# w8RjMA0GCSqGSIb3DQEBAQUABIIBAJP8EKE7EXmugZpqcaIwYN6GtwGUzv6sEqhc
# uK23Jg7GgdduWLSvoeF+V4RO2VqGdbgWLdbjiFokBMQDxX7K09VYdmppliZNy4v4
# Q/1rT0+JoMFABlpaXg0VLSixktVnJcKAjofICgXcfncyovHxlPwpp8zPfCxOQ6lw
# ZJ3kCLmvq/PnCRVpC35lJ5xwwkQe9f/em/tL3kfNq0acku+Oim7cTw0kzCzbV7o5
# jiTP3t1H4qaHLXA1Ltm7kGTCd8cCaqCg+7TfYEa9Mc6LiO7QcRUE1lq9V3w7oNV3
# t95H1HR8y07DbAzLWVkqcYCeHZYSYFKzbbsO0MSiweRQWvTQYsmhggNMMIIDSAYJ
# KoZIhvcNAQkGMYIDOTCCAzUCAQEwgZIwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
# EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMP
# U2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1w
# aW5nIENBAhEAjHegAI/00bDGPZ86SIONazANBglghkgBZQMEAgIFAKB5MBgGCSqG
# SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDQxNDEzMzg0
# MFowPwYJKoZIhvcNAQkEMTIEMOI35taB45ypP7o7NJGm9/40y5KvOgcxhY1/rZrZ
# cLaB4oqcJhFc/3DY/gxu86ms2TANBgkqhkiG9w0BAQEFAASCAgBDN6cSgkoby6OB
# 0qsj7zmSe2Tsk9MzYnq4PO7hVNzQlyCqWpGdGygE/guJpM2XxsikPDZlvXr2Luhr
# /jvdUAuwbcYvsxfHUQPxtVtDC0MbPYXPkPKys9Yrx271LMH/WdYfMyleKLKe+V9t
# xowjtUW5ecQaXQJ02Wn4WS5FoiTFiqRiwysWo+uB3DL4iJknQ1gOEwdYnbyurHnn
# y+Rpqxw0YOfL+lCiSaAmYYedojmmMlQARdFqpjBqEIvnNkByAM7eoWyt3Gm2Dn0f
# nQQ1MEbWwKHPTxVmL9SqwktIgU6BeQYsj6FjB8sO07dqUdiCS9tIz3Woj/2rbRu+
# RbPR2YokioMd+Tk6bF2a8IFUifiBafIcsrVQGSaRALCC499PClaTFUp+g7cFr+NW
# /NYv/otZvTj82Lphb94SHnfX3YIhQRi4PzCZ5Nm+OHphaDMkjrl4IX8vKSDIjGN5
# R6hLCmGOxGAOw5bmhlY40ZyS+nhB9K7ITu3OPWzcz0+ZUaNBN1BNv/8fCuivlypR
# s0K2hvo646VPAkrfFRyMkk7NX+ZsAZkly38L/5+WxPfMVEZIyq5D9q5EzdYfsazA
# 5W7ruxqhrmDSWaQtr3vdLGf9ZUsHBakRVxjkMPURoRTVZsaHXm71WNw2Gzjwgz7M
# ojsHeVgqn2X5i98elY4Yswkix0EZXA==
# SIG # End signature block
