#imports AD module
Import-Module ActiveDirectory

# sets local location, modify if needed 
#Set-Location '.\Desktop'

# saves Distinguished name of Example-group into distro group
$corpUser = "CN=Example User,OU=ExampleOU,DC=example,DC=domain,DC=com"

Get-ADGroup -Identity $corpUser

$newDomains = Import-Csv -Path ".\newDomains.csv"

foreach ($domain in $newDomains)
{
    $alias = "corpUser@"+$domain.Domain 
    Write-Host "Currently adding the current $alias"
    Set-ADGroup -Identity $corpUser -add @{ProxyAddresses="smtp:$alias"}
}