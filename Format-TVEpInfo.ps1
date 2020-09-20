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
        [PSCustomObject[]]
        $InputObject,

        # Must be up to 3 characters in length
        [ValidateLength(1,3)]
        [string]
        $Extension,

        # Will remove numbers from the Season and replace them with roman numerals
        [switch]
        $RomanNumerals,

        # Will remove NTFS illegal characters / ? < > \ : * | " from the Episode Title 
        [switch]
        $RemoveIllegalChar
    )
    PROCESS {
            
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

                # Actual function below
                function ConvertTo-RomanNumeral {

                    # Input needs to be tuned/fixed
                    $number = 1
                
                    $outputX = $null
                    $outputIX = $null
                    $outputV = $null
                    $outputIV = $null
                    $outputI = $null
                
                    # Roman "X"
                    if (($number / 10) -ge 1) {
                
                        $numeral = "X"
                        $result = [System.Math]::Floor($number / 10)
                
                        $outputX = $numeral * $result
                        
                        # Sets the remainder for the next if statement
                        $number = $number % 10
                
                    } #if
                
                    # Roman "IX"
                    if (($number / 9) -ge 1) {
                    
                
                        $numeral = "IX"
                        $result = [System.Math]::Floor($number / 9)
                
                        $outputIX = $numeral * $result
                
                        # Sets the remainder for the next if statement
                        $number = $number % 9
                    } #if
                
                    # Roman "V"
                    if (($number / 5) -ge 1) {
                    
                
                        $numeral = "V"
                        $result = [System.Math]::Floor($number / 5)
                
                        $outputV = $numeral * $result
                
                        # Sets the remainder for the next if statement
                        $number = $number % 5
                
                    } #if
                
                    # Roman "IV"
                    if (($number / 4) -eq 1) {
                    
                        $numeral = "IV"
                        $result = [System.Math]::Floor($number / 4)
                
                        $outputIV = $numeral * $result
                        
                        # Sets the remainder for the next if statement
                        $number = $number % 4
                        
                    } #if
                
                    # Roman "I"
                    if (($number / 1) -ge 1) {
                    
                
                        $numeral = "I"
                        $result = [System.Math]::Floor($number / 1)
                
                        $outputI = $numeral * $result
                
                
                    } #if
                
                    $finaloutput = $outputX + $outputIX + $outputV + $outputIV + $outputI
                    $finaloutput
                
                } #function

                # This is what will swap the number itself
                $eptitle = $eptitle -replace "[0-9]", #-replace: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7
                
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


