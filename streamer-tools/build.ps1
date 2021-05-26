$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt
if ($args.Count -eq 0) {
$ModID = "streamer-tools"
$VERSION = "0.1.0-InDev"
$BSHook = "1_3_5"
$codegen_ver = "0_8_1"
}

if ($args[0] -eq "--actions") {
    $ModID = $env:module_id
    $BSHook = $env:bs_hook
    $VERSION = $env:version
    $codegen_ver = $env:codegen
}
echo "Building mod with ModID: $ModID version: $VERSION, BS-Hook version: $BSHook"

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk VERSION=$VERSION BSHook=$BSHook codegen_ver=$codegen_ver

echo Done
