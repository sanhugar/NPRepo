[CmdletBinding()]
Param(
	[Parameter(Mandatory=$true)]
		[string]$name,
	[Parameter(Mandatory=$true)]
		[string]$region
	)
$result = @"
{
	"Result":"",
	"Score":0	
}
"@
$global:resultScore=$result | ConvertFrom-JSON
#Check for region whether it is matching with given region
function IsValidRegion($regionName)
{
	$rgList=Get-AzResourceGroup
	#Write-Output "Checking of VM $vmName"
	Foreach ($rg in $rgList)
	{
		#Write-Output $vm.Name
		if($rg.Name -eq $rgList)
		{
			return $true
		}
	}
	return $false
}
#Check for resourcegroup in a list
function IsRGExists($rgName)
{
	$rgList=Get-AzResourceGroup
	#Write-Output "Checking of VM $vmName"
	Foreach ($rg in $rgList)
	{
		#Write-Output $vm.Name
		if($rg.Name -eq $rgList)
		{
			return $true
		}
	}
	return $false
}
#Check for VM in a list
function IsVMExists($vmName)
{
	$vmList=Get-AzVM
	#Write-Output "Checking of VM $vmName"
	Foreach ($vm in $vmList)
	{
		Write-Output $vm.Name
		if($vm.Name -eq $vmName)
		{
			return $true
		}
	}
	return $false
}
#Publish score
function Publish-Score()
{
	if($global:resultScore.Score -gt 0)
	{
		$global:resultScore.Result="Pass"
	}
	else
	{
		$global:resultScore.Result="Fail"
	}
	$resultString = $global:resultScore | ConvertTo-JSON
	Write-Output $resultString
}
#Master Function
function Start-Eval()
{
	$Score=0
	if((IsVMExists $name) -eq $true)
	{
		#Write-Output "VM found"
		$global:resultScore.Score= $global:resultScore.Score+5
	}	
	Publish-Score
}
Start-Eval
#Write-Output "Params Received = $name, $place"
