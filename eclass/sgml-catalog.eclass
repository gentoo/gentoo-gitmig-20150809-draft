# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Matthew Turk <satai@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/sgml-catalog.eclass,v 1.3 2003/01/03 05:05:55 satai Exp $
#

inherit base
INHERITED="$INHERITED $ECLASS"

newdepend ">=sgml-common-0.6.3-r2"
ECLASS=sgml-catalog

declare -a toinstall
declare -i catcounter
let "catcounter=0"

sgml-catalog_cat_include() {
    debug-print function $FUNCNAME $*
    toinstall["catcounter++"]="${1}:${2}"
}

sgml-catalog_cat_doinstall() {
    debug-print function $FUNCNAME $*
    /usr/bin/install-catalog --add $1 $2 &>/dev/null
}

sgml-catalog_cat_doremove() {
    debug-print function $FUNCNAME $*
    /usr/bin/install-catalog --remove $1 $2 &>/dev/null
}

sgml-catalog_pkg_postinst() {
    debug-print function $FUNCNAME $*
    declare -i topindex
    topindex="catcounter-1"
    for i in `seq 0 ${topindex}`
    do
        arg1=`echo ${toinstall[$i]} | cut -f1 -d\:`
        arg2=`echo ${toinstall[$i]} | cut -f2 -d\:`
        if [ ! -e $arg2 ]
        then
            ewarn "${arg2} doesn't appear to exist, although it ought to!"
            continue
        fi
        einfo "Now adding $arg1 to $arg2 and /etc/sgml/catalog"
        sgml-catalog_cat_doinstall $arg1 $arg2
    done
    sgml-catalog_cleanup
}

sgml-catalog_pkg_prerm() {
    sgml-catalog_cleanup
}

sgml-catalog_pkg_postrm() {
    debug-print function $FUNCNAME $*
    declare -i topindex
    topindex="catcounter-1"
    for i in `seq 0 ${topindex}`
    do
        arg1=`echo ${toinstall[$i]} | cut -f1 -d\:`
        arg2=`echo ${toinstall[$i]} | cut -f2 -d\:`
        if [ -e $arg2 ] 
        then
            ewarn "${arg2} still exists!  Not removing from ${arg1}" 
            ewarn "This is normal behavior for an upgrade..."
            continue
        fi
        einfo "Now removing $arg1 from $arg2 and /etc/sgml/catalog"
        sgml-catalog_cat_doremove $arg1 $arg2
    done
}

sgml-catalog_cleanup() {
    if [ -e /usr/bin/gensgmlenv ]
    then
        einfo Regenerating SGML environment variables...
        gensgmlenv
        grep -v export /etc/sgml/sgml.env > /etc/env.d/93sgmltools-lite
    fi
}

sgml-catalog_src_compile() {
    return
}

EXPORT_FUNCTIONS pkg_postrm pkg_postinst src_compile pkg_prerm
