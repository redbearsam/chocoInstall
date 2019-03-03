class ChocoPackage {

    ChocoPackage([string]$_name, [string]$_chocoName) {
        $this.name = $_name;
        $this.chocoName = $_chocoName;
        $this.success = $false;
        $this.pending = $true;
        $this.available = $true;
    }

    ChocoPackage([string]$_name) {
        $this.name = $_name;
        $this.chocoName = $_name;
        $this.success = $false;
        $this.pending = $true;
        $this.available = $true;
    }

    ChocoPackage([string]$_name, [string]$_chocoName, [boolean]$_available) {
        $this.name = $_name;
        $this.chocoName = $_chocoName;
        $this.success = $false;
        $this.pending = $true;
        $this.available = $_available;
    }

    ChocoPackage([string]$_name, [boolean]$_available) {
        $this.name = $_name;
        $this.chocoName = $_name;
        $this.success = $false;
        $this.pending = $true;
        $this.available = $_available;
    }

    [string]$name;
    [string]$chocoName;

    [boolean]$success;
    [boolean]$pending;

    [boolean]$available

    [string]$response

    [boolean]Install() {
        if ($this.available -ne $true) 
        {
            $nme = $this.name;
            Write-Host "Package $nme not available. Skipping." -ForegroundColor Red
            $this.pending = $false;
            $this.success = $false;
            return $this.success;
        }

        [console]::beep(800, 900);
        Write-Host "Installing $($this.name)...." -ForegroundColor Magenta
        
        try 
        {
            # $result = choco install $this.chocoName -y | Out-Host
	    # Write-Host "Result: $result"
            # if ($result -eq 0)
	    $result = choco install $this.chocoName -y 
	    Write-Host $result;
	    $target = $this.chocoName;
	    if ($result -match "install of $target was successful")
            {
                $this.success = $true;
                Write-Host "Installation of $($this.name) successful." -ForegroundColor Magenta
            }
            else 
            {
                $this.success = $false;
                Write-Host "Installation of $($this.name) failed." -ForegroundColor Red
            }
        }
        catch
        {
            $excep = $_;
            Write-Host $excep;
            $this.success = $false;
            Write-Host "Installation of $($this.name) failed." -ForegroundColor Red
        }
        
        $this.pending = $false;
        return $this.success;
    }
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ START SCRIPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[boolean]$testMode = $false;
if ($testMode) 
{
    Write-Host "Test Mode Enabled." -ForegroundColor Green -BackgroundColor Black
}

$utilities = @{
    name     = "utilities";
    contents = @(
        [ChocoPackage]::new("7zip", "7zip.install"),
        [ChocoPackage]::new("mouse without borders", "mousewithoutborders"),
        [ChocoPackage]::new("conemu"),
        [ChocoPackage]::new("dupeguru"),
        [ChocoPackage]::new("dupeguru-pe"),
        [ChocoPackage]::new("windirstat"),
        [ChocoPackage]::new("jdownloader"),
        [ChocoPackage]::new("totalcommander"),
        [ChocoPackage]::new("curl"),
        [ChocoPackage]::new("sysinternals"),
        [ChocoPackage]::new("freedownloadmanager", $false), #currently broken
        [ChocoPackage]::new("refract-dns", $false) #not yet available
    );
}

$office = @{
    name     = "office";
    contents = @(
        [ChocoPackage]::new("onenote"),
        [ChocoPackage]::new("onetastic")
    )
}

$hardwareMonitoring = @{
    name     = "hardwareMonitoring";
    contents = @(
        [ChocoPackage]::new("geforce-experience"),
        [ChocoPackage]::new("gpu-z"),
        [ChocoPackage]::new("cpu-z", "cpu-z.install"),
        [ChocoPackage]::new("realtemp", $false) #currently broken
    )
}

$comms = @{
    name     = "comms";
    contents = @(
        [ChocoPackage]::new("slack"),
        [ChocoPackage]::new("microsoft teams", "microsoft-teams"),
        [ChocoPackage]::new("caprine", $false) #not yet available
    )
}

$media = @{
    name     = "media";
    contents = @(
        [ChocoPackage]::new("steam"),
        [ChocoPackage]::new("cccp", $false), #currently broken
        [ChocoPackage]::new("k-lite codec pack", "k-litecodecpackfull"),
        [ChocoPackage]::new("vlc"),
        [ChocoPackage]::new("adobe reader", "adobereader"),
        [ChocoPackage]::new("inkscape"),
        [ChocoPackage]::new("gimp"),
        [ChocoPackage]::new("freemake audio converter", "freemake-audio-converter"),
        [ChocoPackage]::new("winamp"),
        [ChocoPackage]::new("spotify"),
        [ChocoPackage]::new("youtube-dl"),
        [ChocoPackage]::new("youtube-dl GUI", "youtube-dl-gui.install"),
        [ChocoPackage]::new("zune", $false), #not yet available
        [ChocoPackage]::new("cakewalk", $false), #not yet available
        [ChocoPackage]::new("worldographer", $false) #not yet available
    )
}

$development = @{
    name     = "development";
    contents = @(
        [ChocoPackage]::new("git"),
        [ChocoPackage]::new("fiddler"),
        [ChocoPackage]::new("jdk11"),
        [ChocoPackage]::new("jdk8"),
        [ChocoPackage]::new("node.js", "nodejs.install"),
        [ChocoPackage]::new("postman"),
        [ChocoPackage]::new("poshgit"),
        [ChocoPackage]::new("python3"),
        [ChocoPackage]::new("putty", "putty.install"),
        [ChocoPackage]::new("vscode"),
        [ChocoPackage]::new("resharper", "resharper-platform"),
        [ChocoPackage]::new("intellij", "intellijidea-community"),
        [ChocoPackage]::new("tortoisegit")
    )
}

$browsers = @{
    name     = "browsers";
    contents = @(
        [ChocoPackage]::new("firefox"),
        [ChocoPackage]::new("googlechrome"),
        [ChocoPackage]::new("vivaldi")
    )
}

$testing = @{
    name     = "testing";
    contents = @(
        [ChocoPackage]::new("cccp"),
        [ChocoPackage]::new("huisnapoin;mimasduboasd")
    )
}

$packageGroups = @($utilities, $office, $hardwareMonitoring, $comms, $media, $development, $browsers);
if ($testMode) 
{
    $packageGroups = @($testing);
}

$totalCount = 0;
#$temp = $packageGroups | ForEach-Object { Select-Object -ExpandProperty contents };
#$totalCount = [Linq.Enumerable]::Sum([Linq.Enumerable]::SelectMany($);
#[Func[ChocoPackage,ChocoPackage]] $delegate = {return $arg[0]}
#[Linq.Enumerable]::SelectMany($packageGroups, $delegate);

$successes = New-Object System.Collections.ArrayList;
$failures = New-Object System.Collections.ArrayList;

$currentCount = 0;
ForEach ($packageGroup in $packageGroups) 
{
    Write-Host "~~~~Installation of package $currentCount/$totalCount, `"$($packageGroup.name)`", commencing....~~~~" -ForegroundColor Magenta
    ForEach ($chocoPackage in $packageGroup.contents) 
    {
        if ($chocoPackage.Install())
        {
            $successes.Add($chocoPackage);
        }
        else 
        {
            $failures.Add($chocoPackage);
        }
    }
    $currentCount++;
    Write-Host "~~~~Installation of `"$($packageGroup.name)`" complete.~~~~" -ForegroundColor Magenta
}

Write-Host "The following packages were successfully installed: " -ForegroundColor Green
ForEach ($package in $successes) {
    Write-Host "$($package.name)" -ForegroundColor Green
}

Write-Host "The following packages were not successfully installed: " -ForegroundColor Red
ForEach ($package in $failures) {
    Write-Host $package.name -ForegroundColor Red
}

# Script should then offer to rerun these installations so that the errors can be brought front and centre, 
# or else the errors should be saved at installation time for examination at this point.