<#

.SYNOPSIS
Run the Go unit tests

#>

[CmdletBinding()]
param (

    [string]
    # Output directory for reports
    $output_dir = "outputs/tests",

    [string]
    # Name of the report file
    $report_file = "report.xml",

    [string]
    # Name of the coverage file
    $coverage_file = "coverage.xml"
)

# Set the temp coverage file
$temp_coverage = [IO.Path]::Combine($output_dir, "coverage.txt")

# If the output directory does not exist, create it
if (!(Test-Path -Path $output_dir)) {
    Write-Output ("Creating output dir: {0}" -f $output_dir)
    New-Item -ItemType Directory -Path $output_dir
}

# Run the unit tests
$report_path = [IO.Path]::Combine($output_dir, $report_file)

Write-Output "Running Unit Tests"
$cmd = ("go test ./... | go-junit-report > {0}" -f $report_path)
Invoke-Expression -Command $cmd

# Create coverage
$coverage_path = [IO.Path]::Combine($output_dir, $coverage_file)

Write-Output "Generating Coverage report"

$cmd = ("go test ./... -v -coverprofile={0}" -f $temp_coverage)
Write-Output $cmd
Invoke-Expression -Command $cmd

$cmd = ("gocover < {0} > {1}" -f $temp_coverage, $coverage_path)
Write-Output $cmd

(get-childitem outputs).Name
Write-Output "------"
get-childitem outputs/tests
get-childitem outputs/tests/coverage
get-content outputs/tests/coverage

# Remove the temporary coverage file
#if (Test-Path -Path $temp_coverage) {
#    Remove-Item -Path $temp_coverage
#}
