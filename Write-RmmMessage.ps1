function Write-RmmMessage {
	[CmdletBinding()]
  Param(
    [Parameter(Mandatory=$True)][String]$RmmMessages,
    [Switch]$WriteDebug,
    [Switch]$WriteAlert
  ); 

  ## Get the timestamp
  if (Get-Command -Name Get-TimeStamp -ErrorAction SilentlyContinue) {
    $TimeStamp = Get-TimeStamp; 
  } else { $TimeStamp = "[{0:yyyy-MM-dd} {0:HH:mm:ss}]" -f (Get-Date); }; 

  ## Check for a message prefix. Can be set as an account variable or a script variable.
  if ([string]::IsNullOrEmpty($ENV:AccountLevelPrefix)) { 
    if ($null -eq $PrefixBullet) { $PrefixBullet = "-"; }; 
  } else { $PrefixBullet = "$ENV:AccountLevelPrefix"; }; 

  ## Process message(s)
  foreach ($Message in $RmmMessages.Split(",")) { 
    if ($WriteDebug)      { Write-RmmDebug "$Message"; }; 
    elseif ($WriteAlert)  { Write-RmmAlert "$Message"; }; 
    else { Write-Host "$TimeStamp $PrefixBullet $Message"; }; 
  }; 
}; 
