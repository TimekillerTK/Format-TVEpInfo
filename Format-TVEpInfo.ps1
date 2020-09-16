function Format-TVEpInfo {
    <#
    .SYNOPSIS
    Some Synopsis

    .DESCRIPTION
    Long description
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [string[]]
        $InputObject
    )
    PROCESS {
        
        foreach ($object in $InputObject) {
            
            #This makes it a string, hence it's visible
            Write-output "$object"
            return $object

        }
    }
}