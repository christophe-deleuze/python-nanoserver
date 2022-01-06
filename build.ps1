#!/usr/bin/env pwsh
$TARGET_PYTHON_VERSION=('3.9.9', '3.10.1')
$TARGET_WINDOWS_VERSION=('1809', '1909', '2004', '20H2', 'ltsc2022')

$TARGET_PYTHON_PIP_VERSION='21.3.1'
$TARGET_PYTHON_GET_PIP_URL='https://github.com/pypa/get-pip/raw/d59197a3c169cef378a22428a3fa99d33e080a5d/get-pip.py'

foreach ($EACH_PYTHON_VERSION in $TARGET_PYTHON_VERSION) {
    foreach ($EACH_WIN_VERSION in $TARGET_WINDOWS_VERSION) {
        $IMAGE_TAG="${EACH_PYTHON_VERSION}_${EACH_WIN_VERSION}"
        docker build `
            -t python-nanoserver:$IMAGE_TAG `
            --build-arg WINDOWS_VERSION=$EACH_WIN_VERSION `
            --build-arg PYTHON_VERSION=$EACH_PYTHON_VERSION `
            --build-arg PYTHON_RELEASE=$EACH_PYTHON_VERSION `
            --build-arg PYTHON_PIP_VERSION=$TARGET_PYTHON_PIP_VERSION `
            --build-arg PYTHON_GET_PIP_URL=$TARGET_PYTHON_GET_PIP_URL `
            .
        docker tag python-nanoserver:$IMAGE_TAG deleuzech/python-nanoserver:$IMAGE_TAG
        docker push deleuzech/python-nanoserver:$IMAGE_TAG
        docker rmi python-nanoserver:$IMAGE_TAG
    }
}

docker container prune
docker image prune
