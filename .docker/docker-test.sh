#!/bin/sh

COLOR_REST="$(tput sgr0)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_RED="$(tput setaf 1)"

function service_info(){
    service=$1
    echo ""
    printf 'Testing service: ' 
    printf '%s%s%s' $COLOR_GREEN $service $COLOR_REST
    echo ""
    echo "======="
}

function assert_result(){
    if [[ "$1" == true ]];
    then
        printf '%s%s%s\n' $COLOR_GREEN 'OK' $COLOR_REST
    else
        printf '%s%s%s\n' $COLOR_RED 'ERROR' $COLOR_REST
    fi;
}

function docker_exec(){
    service=$1
    shift;
    docker exec $(docker ps --filter name=${service} -q | head -1) "$@"
}

function test_container_is_running(){
    service=$1
    result=false
    echo "Checking if '${service}' has a running container"
    echo "$(docker ps --filter name=${service})" | grep -q "${service}" && result=true
    assert_result ${result}
}

function test_host_docker_internal(){
    service=$1
    result=false
    echo "Checking 'host.docker.internal' on '${service}'"
    docker_exec ${service} dig host.docker.internal | grep -vq NXDOMAIN && result=true
    assert_result ${result}
}

service="hub"
service_info ${service}
test_container_is_running ${service}
test_host_docker_internal ${service}
echo "Checking 'status' on '${service}'"
curl 127.0.0.1:4444/wd/hub/status 

service="node-chrome"
service_info ${service}
test_container_is_running ${service}
test_host_docker_internal ${service}

service="node-firefox"
service_info ${service}
test_container_is_running ${service}
test_host_docker_internal ${service}


