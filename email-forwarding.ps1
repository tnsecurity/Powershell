# Install the Exchange Online Management Module if not already installed
Install-Module -Name ExchangeOnlineManagement
Install-Module -Name AzureAD

# List of users with their forwarding addresses
$userForwardingList = @{
   "yourID@yourdomain.com" = "youremailwhereyouwouldliketoforward"

   }

# Admin login credentials
$adminUser = "youradminemailaddress"

# Login to Exchange Online
Write-Host "Logging in to Exchange Online as $adminUser..."
Connect-ExchangeOnline -UserPrincipalName $adminUser -ShowProgress $true

# Loop through each user and set email forwarding
foreach ($user in $userForwardingList.Keys) {
    $forwardingAddress = $userForwardingList[$user]

    Write-Host "Setting email forwarding for $user to $forwardingAddress"

    try {
        # Set the forwarding address
        Set-Mailbox -Identity $user -ForwardingSMTPAddress $forwardingAddress -DeliverToMailboxAndForward $true
        Write-Host "Email forwarding set for $user"
    }
    catch {
        Write-Host "Error setting forwarding for ${user}: $_"
    }
}

Write-Host "Email forwarding process completed for all users."

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
