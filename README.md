# Format-TVEpInfo
Intended to format input objects into a string suitable for file names.
* Example output: `Show Title - Season 2 - Episode 034 - Episode Title.txt`

## How to use
* `Import-CSV c:\file.csv | Format-TVEpInfo -Extension txt`
* `Get-TVEpList https://url.com/show/season/1 | Format-TVEpInfo -Extension txt`
* Check `Get-Help Format-TVEpInfo`

## Todo
- Current way of passing parameters to the cmdlet is a bit strange - should accept a custom format akin to `Get-Date -Format "dddd MM/dd/yyyy HH:mm K"` for displaying Season/Episode/etc
- `ConvertTo-RomanNumeral` function has too many if statements, need to check if it can be turned into a switch or programmed more efficiently.