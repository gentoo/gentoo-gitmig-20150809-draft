# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kmod.eclass,v 1.1 2002/08/27 23:32:05 mjc Exp $
# The base eclass defines some default functions and variables. Nearly everything
# else inherits from here.
ECLASS=kmod
INHERITED="$INHERITED $ECLASS"
S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

base_src_unpack() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && base_src_unpack all

	cd ${WORKDIR}

	while [ "$1" ]; do

	case $1 in
	    unpack)
			debug-print-section unpack
			# rather ugly fix - check for usage of kde-patch.eclass
			[ -n "$PATCH" -a -n "$ORIGPV" -a -n "$DATE" -a -n "$OLDIFS" ] && \
			    A="`echo $A | sed -e s:${PATCH}::g --`"
			unpack ${A}
			;;
	    patch)
			debug-print-section patch
			cd ${S}
			patch -p0 < ${FILESDIR}/${P}-gentoo.diff
			;;
	    autopatch)
			debug-print-section autopatch
			debug-print "$FUNCNAME: autopatch: PATCHES=$PATCHES"
			cd ${S}
			for x in $PATCHES; do
			    debug-print "$FUNCNAME: autopatch: patching from ${x}"
			    patch -p0 < ${x}
			done
			;;
	    all)
			debug-print-section all
			base_src_unpack unpack autopatch
			;;
	    esac

	shift
	done
    
}

base_src_compile() {

    debug-print-function $FUNCNAME $*
    [ -z "$1" ] && base_src_compile all

    cd ${S}

    while [ "$1" ]; do

	case $1 in
	    configure)
		debug-print-section configure
		econf || die "died running econf, $FUNCNAME:configure"
		;;
	    make)
		debug-print-section make
		emake || die "died running emake, $FUNCNAME:make"
		;;
	    all)
		debug-print-section all
		base_src_compile configure make
		;;
	esac
	
    shift
    done
    
}

base_src_install() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && base_src_install all

	cd ${S}

	while [ "$1" ]; do

	case $1 in
	    make)
			debug-print-section make
			make DESTDIR=${D} install || die "died running make install, $FUNCNAME:make"
			;;
	    all)
			debug-print-section all
			base_src_install make
			;;
	esac

	shift
	done

}

EXPORT_FUNCTIONS src_unpack src_compile src_install
