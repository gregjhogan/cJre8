Configuration cJre8 {
    param
    (
        [string]
        $BundleId = "211999",
        [string]
        $LocalPath = "$env:SystemDrive\Windows\DtlDownloads\JRE8"
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    xRemoteFile Downloader
    {
        Uri = "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=$BundleId"
        DestinationPath = "$LocalPath\JreInstall$BundleId.exe"
    }

    Package Installer
    {
        Ensure = 'Present'
        Name = "Java 8"
        Path = "$LocalPath\JreInstall$BundleId.exe"
        Arguments = "/s REBOOT=0 SPONSORS=0 REMOVEOUTOFDATEJRES=1 INSTALL_SILENT=1 AUTO_UPDATE=0 EULA=0 /l*v `"$LocalPath\JreInstall$BundleId.log`""
        ProductId = "26A24AE4-039D-4CA4-87B4-2F64180101F0"
        DependsOn = "[xRemoteFile]Downloader"
    }
}
