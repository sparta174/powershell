$ToBeDeleted = Import-CSV '*' | Select-Object -ExpandProperty Name
$Where = '*'
$Delete = $Where + $ToBeDeleted

foreach ($FolderName in $ToBeDeleted) {
    Invoke-Command -ScriptBlock {
        Remove-Item -force $Delete
    }
}
#$ToBeDeleted | ForEach-Object {
#    $Deletion = $Where + $ToBeDeleted
#    Remove-Item -recurse -force $Deletion }
