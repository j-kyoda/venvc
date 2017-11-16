#!/bin/bash
#
# python virtualenv controle
#

function vec_help() {
    echo "Usage: ${CMDNAME} [command]" >&2
    echo "Operate Python virtualenv." >&2
    echo "" >&2
    echo "Command:" >&2
    echo "  auto                       create, reinstall, update and export" >&2
    echo "  export                     export package list" >&2
    echo "  reinstall                  reinstall packages" >&2
    echo "  create                     create virtualenv" >&2
    echo "  remove                     remove virtualenv" >&2
    echo "  update                     update package" >&2
    echo "" >&2
}

function vec_create() {
    ${PYVENV} ${VENV_DIR}
    touch ${EXPORT_FILE}
}

function vec_activate() {
    if [ -d "${VENV_DIR}" ]
    then
        source ${VENV_DIR}/bin/activate
    fi
}

function vec_deactivate() {
    deactivate
}

function vec_export() {
    pip freeze > "${EXPORT_FILE}"
}

function vec_reinstall() {
    if [ -e "${EXPORT_FILE}" ] && [ -s "${EXPORT_FILE}" ]
    then
        pip install -r "${EXPORT_FILE}"
    fi
}

function vec_update() {
    res=$(pip list -o --format=legacy)
    if [ "${res}" != "" ]
    then
        # update all packages
        echo "${res}" | while read line
        do
            if [ "${line}" != "" ]
            then
                echo "${line}"  | cut -d ' ' -f 1 | xargs pip install -U
            fi
        done
    fi
}

function vec_auto() {
    if [ ! -d "${VENV_DIR}" ]
    then
        vec_create
        vec_activate
        vec_reinstall
    else
        vec_activate
    fi
    vec_update
    vec_export
    vec_deactivate
}

function vec_remove() {
    if [ -d "${VENV_DIR}" ]
    then
        rm -rf ${VENV_DIR}
    fi
}

#
# main
#
CONFNAME=venvc.conf
CMDNAME=$(basename $0)
cd $(dirname $0)

if [ ! -e "${CONFNAME}" ]
then
    echo "${CONFNAME} not found" >2
    exit 1
fi
. ${CONFNAME}

if [ $# -eq 1 ]
then
    if [ $1 = "auto" ]
    then
        vec_auto
    elif [ $1 = "export" ]
    then
        vec_activate
        vec_export
        vec_deactivate
    elif [ $1 = "reinstall" ]
    then
        vec_activate
        vec_reinstall
        vec_deactivate
    elif [ $1 = "create" ]
    then
        vec_create
    elif [ $1 = "remove" ]
    then
        vec_remove
    elif [ $1 = "update" ]
    then
        vec_activate
        vec_update
        vec_deactivate
    else
        vec_help
    fi
else
    vec_help
fi
exit 0
