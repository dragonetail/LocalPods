
PODSPEC=`ls *.podspec`
PREVersion="$1"
TARGETVersion="$2"

if test -z "${PREVersion}" -o -z "${TARGETVersion}"
then
	echo "pod_publish <PREVersion> <TARGETVersion>"
	exit -1
fi

echo PREVersion=${PREVersion}
echo TARGETVersion=${TARGETVersion}

PREVersionTo=${PREVersion//\./\\\.}
TARGETVersionTo=${TARGETVersion//\./\\\.}
#echo sed -i \'\' \"s/${PREVersion//\./\\\.}/${TARGETVersion//\./\\\.}/g\" ${PODSPEC}
sed -i '' "s/${PREVersionTo}/${TARGETVersionTo}/g" ${PODSPEC}

echo "~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Add, commit and push ..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~"
git add -A && git commit -m "Release ${TARGETVersion}" . && git push

echo "~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Tag, and push to ${TARGETVersion} ..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~"
git tag "${TARGETVersion}" && git push --tags

echo "~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Publish to pod ..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~"
pod trunk push ${PODSPEC}

