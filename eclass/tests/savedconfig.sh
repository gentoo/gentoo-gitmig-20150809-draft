#!/bin/bash

source tests-common.sh

inherit savedconfig

sc() { EBUILD_PHASE=install save_config "$@" ; }
rc() { EBUILD_PHASE=prepare restore_config "$@" ; }

tbegin "simple save_config"
sc $0 >/dev/null
ret=$?
[[ -f ${ED}/etc/portage/savedconfig/${CATEGORY}/${PF} ]]
tend $(( ret + $? ))
rm -rf "${ED}/etc"

tbegin "multi save_config"
sc *.sh >/dev/null
ret=$?
[[ -d ${ED}/etc/portage/savedconfig/${CATEGORY}/${PF} ]]
tend $(( ret + $? ))
rm -rf "${ED}/etc"

tbegin "dir save_config"
sc CVS >/dev/null
ret=$?
[[ -d ${ED}/etc/portage/savedconfig/${CATEGORY}/${PF} ]]
tend $(( ret + $? ))
rm -rf "${ED}/etc"

texit
