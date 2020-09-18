function Format-TVEpInfo {
    <#
    .SYNOPSIS
    Some Synopsis

    .DESCRIPTION
    Long description

    .PARAMETER REMOVEILLEGALCHAR
    Removes NTFS illegal characters / ? < > \ : * | "
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [PSCustomObject[]]
        $InputObject,

        # Must be up to 3 characters in length
        [ValidateLength(1,3)]
        [string]
        $Extension,

        # Will remove numbers from the Season and 
        [switch]
        $RomanNumerals,

        [switch]
        $RemoveIllegalChar
    )
    PROCESS {
            
        $RomanNumeralsList = @{
            "I"  = 1
            "IV" = 4
            "V"  = 5
            "IX" = 9
            "X"  = 10
        }
        # fixed the issue with PSCustomObject type, this was a TYPE issue
        #Write-output $InputObject


        # Switch for adding a leading zeroes to episode number moved to Get-TVEpList

        # Loop is accepting values one by one, which is why object count will always be 1
        # This foreach is probably useless, get rid of it later      
        foreach ($object in $InputObject) {

            # Setting variables, kind of optional, but will avoid changing the object in the pipeline permanently
            $eptitle = $object.EpTitle
            $season = $object.Season
            $showtitle = $object.ShowTitle
            $date = $object.Date
            $episode = $object.Episode

            if ($PSBoundParameters.ContainsKey('RemoveIllegalChar')) {
                    
                # NTFS illegal characters for filenames, regex format
                $illegalchar = "\'", "\""", "\/", "\?", "\<", "\>", "\\", "\:", "\*", "\|" 
    
                # Loop that goes over each illegal character
                foreach ($item in $illegalchar) {
                    $eptitle = $eptitle -replace $item,""            
                } #foreach
            } #if

            # This block deals with the RomanNumerals parameter
            if ($PSBoundParameters.ContainsKey('RomanNumerals')) {

                # Temporary operation, will be replaced by roman numerals in the future
                $eptitle = $eptitle -replace '[0-9]','R'

            } #if


            $output = "$($showtitle) - Episode $($episode) - $($eptitle)"

            # This block deals with the Extension parameter
            if ($PSBoundParameters.ContainsKey('Extension')) {
                
                $output = $output + ".$($Extension)"
            
            } #if 
        
        } #foreach


        
        return $output

    } #PROCESS
} #function


