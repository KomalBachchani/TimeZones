function Get-CommonTimeZone {
  <#
        .SYNOPSIS
        Returns the list of time zones and values provided in parameter

        .DESCRIPTION
        Returns the list of time zones and values based on the multiple parameter values post extracting the list of timezones from a json file.

        .PARAMETER Name
        Specifies the name or keyword present in time zone.

        .PARAMETER Offset
        Specifies the time zone offset values. Accepted values ranges from -12 to 12.

        .INPUTS
        None. As of now no pipeline to cmdlet is accepted.

        .OUTPUTS
        System.Object. Get-CommonTimeZone returns the list time zones

        .EXAMPLE
        PS> Get-CommonTimeZone
        value                           abbr  offset isdst text                                                          utc
        -----                           ----  ------ ----- ----                                                          ---
        Dateline Standard Time          DST      -12 False (UTC-12:00) International Date Line West                      {Etc/GMT+12}
        UTC-11                          U        -11 False (UTC-11:00) Coordinated Universal Time-11                     {Etc/GMT+11, Pacific/Midway, Pacific/Niue, Pacific/Pa...
        Hawaiian Standard Time          HST      -10 False (UTC-10:00) Hawaii                                            {Etc/GMT+10, Pacific/Honolulu, Pacific/Johnston, Paci...
        Namibia Standard Time           NST        1 False (UTC+01:00) Windhoek                                          {Africa/Windhoek}

        .EXAMPLE
        PS> Get-CommonTimeZone -Offset 9.5 | Format-Table
        value                        abbr offset isdst text                 utc
        -----                        ---- ------ ----- ----                 ---
        Cen. Australia Standard Time CAST    9.5 False (UTC+09:30) Adelaide {Australia/Adelaide, Australia/Broken_Hill}
        AUS Central Standard Time    ACST    9.5 False (UTC+09:30) Darwin   {Australia/Darwin}

        .EXAMPLE
        PS> Get-CommonTimeZone -Name Asia | Format-Table
        value                         abbr  offset isdst text                                utc
        -----                         ----  ------ ----- ----                                ---
        West Asia Standard Time       WAST       5 False (UTC+05:00) Ashgabat, Tashkent      {Antarctica/Mawson, Asia/Aqtau, Asia/Aqtobe, Asia/Ashgabat...}
        Central Asia Standard Time    CAST       6 False (UTC+06:00) Nur-Sultan (Astana)     {Antarctica/Vostok, Asia/Almaty, Asia/Bishkek, Asia/Qyzylorda...}
        SE Asia Standard Time         SAST       7 False (UTC+07:00) Bangkok, Hanoi, Jakarta {Antarctica/Davis, Asia/Bangkok, Asia/Hovd, Asia/Jakarta...}
        N. Central Asia Standard Time NCAST      7 False (UTC+07:00) Novosibirsk             {Asia/Novokuznetsk, Asia/Novosibirsk, Asia/Omsk}
        North Asia Standard Time      NAST       8 False (UTC+08:00) Krasnoyarsk             {Asia/Krasnoyarsk}
        North Asia East Standard Time NAEST      8 False (UTC+08:00) Irkutsk                 {Asia/Irkutsk}

        .LINK
        Online link for time zone json file: https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json
  #>
  [CmdletBinding(DefaultParameterSetName = 'All')]
  Param(
    [Parameter(Mandatory = $false, ParameterSetName = "Name")]
    [string] $Name,
    [Parameter(Mandatory = $false, ParameterSetName = "Offset")]
    [ValidateRange(-12, 12)][float] $Offset
  )
  try {
    $timeZoneData = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json" -ErrorAction Stop ) | ConvertFrom-Json -ErrorAction Stop
    if ($null -eq $timeZoneData) {
      Write-Host "Info: No time zone data found. "
      return $null
    }
    switch ($PSCmdlet.ParameterSetName) {
      'All' {
        return $timeZoneData
      }
      'Name' {
        return ($timeZoneData | Where-Object -FilterScript { $_.value -like "*$Name*" })
      }
      'Offset' {
        return ($timeZoneData | Where-Object -FilterScript { $_.offset -eq $Offset })
      }
      default {
        return 'Invalid parameter list'
      }
    }
  }
  catch {
    Write-Error "Error: Unable to get time zone. $_"
  }
}

