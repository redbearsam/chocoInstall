# Useful command for checking: 
# New-SmbShare -Name SSD -Path X:\ -FullAccess THREADRIPPER\redbe

$shares = @(
    [pscustomobject]@{
        path = "E:\"
        name = "e"
    },
    [pscustomobject]@{
        path = "F:\"
        name = "f"
    },
    [pscustomobject]@{
        path = "G:\"
        name = "g - tv"
    },
    [pscustomobject]@{
        path = "H:\"
        name = "h - media"
    },
    [pscustomobject]@{
        path = "I:\"
        name = "i - movies"
    },
    [pscustomobject]@{
        path = "K:\"
        name = "k - little"
    }
)

$users = "THREADRIPPER\redbe"

ForEach ($share in $shares) 
{
    # New-SmbShare -Name SSD -Path $path -FullAccess $users
    # Write-Host $share.path $share.name $users
    New-SmbShare -Name $share.name -Path $share.path -FullAccess $users
}
