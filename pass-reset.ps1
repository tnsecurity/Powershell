# Install AzureAD Module if not already installed
Install-Module -Name AzureAD

# List of users
$users = @(
    "youremail@yourdomain.com",

)

# Default password
$defaultPassword = "enteryourpassword"

# Admin login credentials
$adminUser = "youremail@yourdomain.com"

# Login to Azure AD
Write-Host "Logging in to Azure AD as $adminUser..."
Connect-AzureAD

# Loop through each user and set the password and force them to change it at the next login
foreach ($user in $users) {
    # Get the user object from Azure AD
    Write-Host "Processing user: $user"
    try {
        $userObject = Get-AzureADUser -ObjectId $user

        # Set the password for the user and enforce a password change at next login
        Set-AzureADUserPassword -ObjectId $userObject.ObjectId -Password $defaultPassword -ForceChangePasswordNextSignIn $true

        Write-Host "Password set and change on next login enforced for: $user"
    }
    catch {
        Write-Host "Error processing user ${user}: $_"
    }
}

Write-Host "Password update process completed for all users."
