#!/usr/bin/env bash

__scriptpath=$(cd "$(dirname "$0")"; pwd -P)

__toolRuntime=$__scriptpath/Tools

# The path that init-tools should download a PackageVersionProps file to, if it downloads one.
export DotNetPackageVersionPropsDownloadPath="$_toolRuntime/DownloadedPackageVersionProps/PackageVersions.props"

# Source the init-tools.sh script rather than execute in order to preserve ulimit values in child-processes. https://github.com/dotnet/corefx/issues/19152
. $__scriptpath/init-tools.sh

# If there is a downloaded package version props, use it.
if [ -e "$DotNetPackageVersionPropsDownloadPath" ]; then
    export DotNetPackageVersionPropsPath="$DotNetPackageVersionPropsDownloadPath"
    echo "Passing downloaded package version props to DotNetPackageVersionPropsPath: $DotNetPackageVersionPropsDownloadPath"
fi

__dotnet=$__toolRuntime/dotnetcli/dotnet

cd $__scriptpath
$__dotnet $__toolRuntime/run.exe $__scriptpath/config.json $*
exit $?
