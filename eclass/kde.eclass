# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.18 2001/12/11 20:41:03 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit autoconf base depend || die
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

DEPEND="$DEPEND kde-base/kdelibs
				objprelink? ( >=dev-util/objprelink-0-r1 )"
RDEPEND="$RDEPEND kde-base/kdelibs"

kde-objprelink-patch() {
	debug-print-function kde-objprelink-patch $*
	if [ "`use objprelink`" ]; then
	    cd ${S} || die
	    patch -p0 < /usr/share/objprelink/kde-admin-acinclude.patch || die
	    patched=false
	    
	    for x in Makefile.cvs admin/Makefile.common
	    do
		if ! $patched
		then
		    if [ -f $x ]
		    then
			echo "patching file $x (kde-objprelink-patch)" && make -f $x && patched=true || die
		    fi
		fi
	    done

	    $patched || echo "??? Warning: kde-objprelink-patch: patch not applied, makefile not found"
	
	fi

}

kde_src_compile() {

    debug-print-function kde_src_compile $*
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			myconf="${myconf} --host=${CHOST} --with-x --enable-mitshm --with-xinerama --prefix=/usr --with-qt-dir=${QTDIR}"
			use qtmt 	&& myconf="$myconf --enable-mt"
			use objprelink	&& myconf="$myconf --enable-objprelink" || myconf="$myconf --disable-objprelink"
			set-kdedir $kde_version
			set-qtdir $qt_version
			;;
		configure)
			debug-print-section configure
			debug-print "configure: myconf=$myconf"
			./configure ${myconf} || die
			;;
		make)
			debug-print-section make
			LIBRARY_PATH=${LIBRARY_PATH}:${QTDIR}/lib  make || die
			;;
		all)
			debug-print-section all
			kde_src_compile myconf configure make
			;;
	esac

    shift
    done

}

kde_src_install() {

	debug-print-function kde_src_install $*
    [ -z "$1" ] && kde_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
			debug-print-section make
			make install DESTDIR=${D} destdir=${D} || die
			;;
	    dodoc)
			debug-print-section dodoc
			dodoc AUTHORS ChangeLog README* COPYING NEWS TODO
			;;
	    all)
			debug-print-section all
			kde_src_install make dodoc
			;;
	esac

    shift
    done

}

EXPORT_FUNCTIONS src_compile src_install














