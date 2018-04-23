$ToBeDeleted = Import-CSV '\\Mac\Home\Documents\Powershell Scripts\Test\Delete.csv' | Select-Object -ExpandProperty Name
$Where = '\\Mac\Home\Documents\Powershell Scripts\Test\'
$Delete = $Where + $ToBeDeleted

foreach ($FolderName in $ToBeDeleted) {
    Invoke-Command -ScriptBlock {
        Remove-Item -force $Delete
    }
}
#$ToBeDeleted | ForEach-Object {
#    $Deletion = $Where + $ToBeDeleted
#    Remove-Item -recurse -force $Deletion }