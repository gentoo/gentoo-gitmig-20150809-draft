# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/base.eclass,v 1.4 2001/09/29 12:35:38 danarmak Exp $
# The base eclass defines some default functions and variables. Nearly everything
# else inherits from here.
. /usr/portage/eclass/inherit.eclass || die
inherit virtual || die
ECLASS=base

S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

base_src_unpack() {
    
    echo "in base_src_unpack, 1st parameter is $1"
    [ -z "$1" ] && base_src_unpack all
    
    while [ "$1" ]; do
    
	case $1 in
	    unpack)
		echo "in base_src_unpack, action unpack"
		unpack ${A}
		;;
	    all)
		echo "in base_src_unpack, action all"
		base_src_unpack unpack
		;;
        esac
    
    shift
    done
    
}

base_src_compile() {

    echo "in base_src_compile, 1st parameter is $1"
    [ -z "$1" ] && base_src_compile all
    
    while [ "$1" ]; do
    
	case $1 in
	    configure)
		echo "in base_src_compile, action configure"
		./configure || die
		;;
	    make)
		echo "in base_src_compile, action make"
		make || die
		;;
	    all)
		echo "in base_src_compile, action all"
		base_src_compile configure make
		;;
	esac
	
    shift
    done
    
}

base_src_install() {

    echo "in base_src_install, 1st parameter is $1"    
    [ -z "$1" ] && base_src_install all

    while [ "$1" ]; do
    
	case $1 in
	    make)
		echo "in base_src_install, action make"
		make DESTDIR=${D} install || die
		;;
	    all)
		echo "in base_src_install, action all"
		base_src_install make
		;;
	esac
	
    shift
    done
    
}

EXPORT_FUNCTIONS src_unpack src_compile src_install

