#Requires -RunAsAdministrator
clear
Write-Host "Remote Session Killer - 0ut3r.space"
Write-Host " "
  $hostname=Read-Host -Prompt 'Input server name'
Write-Host " "
Write-Host "Checking for sessions on $hostname"
Write-Host " "
  query user /server:$hostname
Write-Host " "
  $sessionID=Read-Host -Prompt 'Choose ID of session you want to kill or press or CTRL+C to quit'
Write-Host " "
Write-Host "How to kill session: Logout or Reset?"
Write-Host " "
Write-Host "Press '1' for logout (safe - recommended)"
Write-Host "Press '2' for reset (hard cut - only if logout didn't work)"
Write-Host "Press 'CTRL+C' to quit."
Write-Host " "
  $selection = Read-Host "Please make a selection"
switch ($selection)
  {
    '1' {
          logoff $sessionID /SERVER:$hostname -v
            Write-Host " "
            Write-Host "Refreshing sessions on $hostname"
          query user /server:$hostname
            Write-Host " "
          $caption = "Session killed?"
          $message = "Please confirm"
          [int]$defaultChoice = 0
          $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Exit script."
          $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Force reset session."
          $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
          $choiceL = $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice)
            if ( $choiceL -ne 1 )
              {
               Write-Host "Great, thast all. Bye bye!"
               Write-Host " "
               exit
              }
            else
              {
                Write-Host "Forcing reset session"
                Write-Host " "
                reset session $sessionID /server:$hostname /V
                Write-Host " "
                Write-Host "Task done! Bye bye!"
                Write-Host " "
                exit
              }
        }
    '2' {
          reset session $sessionID /server:$hostname /V
          Write-Host " "
          Write-Host "Task done! Bye bye!"
          Write-Host " "
        }
  }
