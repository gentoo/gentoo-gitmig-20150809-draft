# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/base.eclass,v 1.1 2001/09/28 19:25:33 danarmak Exp $
# The base eclass defines some default functions and variables. Nearly everything
# else inherits from here.
. /usr/portage/inherit.eclass || die
inherit virtual || die
ECLASS=base

S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

base_src_unpack() {
    
    while [ "$1" ]; do
    
	case $1 in
	    unpack)
		unpack ${A}
		;;
	    all)
		base_src_unpack unpack
		;;
	esac
    
    shift
    done
    
}

base_src_compile() {
    
    while [ "$1" ]; do
    
	case $1 in
	    configure)
		configure || die
		;;
	    make)
		make || die
		;;
	    all)
		base_src_compile configure make
		;;
	esac
	
    shift
    done
    
}

base_src_install() {

    while [ "$1" ]; do
    
	case $1 in
	    make)
		make DESTDIR=${D} install || die
		;;
	    all)
		base_src_install make
		;;
	esac
	
    shift
    done
    
}

EXPORT_FUNCTIONS

