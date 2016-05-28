#!/usr/bin/env bash

env=$2
inventory=$3

export ENVIRONMENT=${env}
export INVENTORY_LIMIT=${inventory}

export REGION=eu-central-1
export INSTANCE_TYPE=t2.micro
export SOURCE_AMI=ami-3de90552
export SSH_USERNAME=ubuntu

export GIT_REPO=git@github.com:stphivos/django-angular2-fullstack-compact.git
export GIT_BRANCH=dev

export SERVER_ROOT_NAME=webapps
export APPLICATION_NAME=fullstack
export PROJECT_NAME=backend
export SERVER_ROOT_PATH=/${SERVER_ROOT_NAME}
export VIRTUALENV_PATH=${SERVER_ROOT_PATH}/${APPLICATION_NAME}
export PROJECT_PATH=${VIRTUALENV_PATH}/${PROJECT_NAME}

setup() {
    vagrant halt && vagrant destroy -f && vagrant up
}

build() {
    cd provisioning/packer
    packer build pack.json
    cd ../../
}

deploy() {
    cd provisioning/terraform
    # args = -var 'app_name=value' \
    #   'public_key_path=value' \
    #   'key_name=value' \
    #   'key=value'
    # terraform plan
    terraform apply
    cd ../../
}

# call arguments verbatim:
$@
