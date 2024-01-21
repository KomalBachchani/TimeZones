# Get-CommonTimeZone

**SYNOPSIS**

Returns the list of time zones and values provided in parameter.

**DESCRIPTION**

Returns the list of time zones and values based on the multiple parameter values post extracting the list of timezones from a json file.

**PARAMETERS**

**-Name**

Type: String        
Parameter Sets: Name        
Aliases: NA        
Required: False        
Position: Named        
Default value: None        
Accept pipeline input: False         
Accept wildcard characters: False        

**-Offset**

Type: Float(Accepted values from -12 to 12)        
Parameter Sets: Offset        
Aliases: NA        
Required: False        
Position: Named        
Default value: None        
Accept pipeline input: False         
Accept wildcard characters: False        

**SYNTAX**

Get-CommonTimeZone [CommonParameters]        
Get-CommonTimeZone [-Name <String>] [-Offset <Float>] [CommonParameters]      

**EXAMPLES**

Get-CommonTimeZone -Offset 9.5 | Format-Table        
Get-CommonTimeZone -Name Asia | Format-Table

**HELP DOCUMENTATION**

Get-Help Get-CommonTimeZone  
Get-Help Get-CommonTimeZone -Examples  

