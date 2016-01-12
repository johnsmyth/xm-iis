describe 'webapp_test::default'  {
    It "Should have the Web Server Role" {
      (Get-WindowsFeature -name Web-Server).Installed | Should Be $true
    }

    It "Should have World Wide Web Publishing Service running" {
      (Get-Service -name 'W3SVC').status | Should Be 'Running'
      (Get-WmiObject win32_service | Where {$_.Name -eq "W3SVC"}).StartMode | Should Be "Auto"
    }

    It "Should not have the default website" {
      Get-Website -Name "Default Web Site" | Should be $null
    }

    It "Should have the XM website" {
      Get-Website -Name "XM" | Should be $true
    }

    It "Should have the index page" {
      $indexPage = Get-Item 'C:\inetpub\wwwroot\xm\index.htm'
      $indexPage | Should Exist
      $indexPage | Should Contain 'DevOps'
    }
}
