# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.53 2002/08/14 19:45:05 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit base kde-functions
ECLASS=kde
INHERITED="$INHERITED $ECLASS"

# is this a kde-base ebuid?
case $PN in
	kde-i18n*|arts|kdeaddons|kdeadmin|kdeartwork|kdebase|kdebindings|kdeedu|kdegames|kdegraphics|kdelibs|kdenetwork|kdepim|kdesdk|kdetoys|kdeutils)
		
		debug-print "$ECLASS: KDEBASE ebuild recognized"
	
		export KDEBASE="true"
		
		# fixups for certain versions
		case $PV in
			3.1_alpha1)	export S="$WORKDIR/$PN-3.0.6" ;;
			3.1_beta1)	export S="$WORKDIR/$PN-3.0.7" ;;
		esac

	    ;;
esac

newdepend /autotools
newdepend "~kde-base/kde-env-3"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://www.kde.org/"

# overridden in other places like kde-dist, kde-source and individual ebuilds
SLOT="0"

kde_src_compile() {

    debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_compile all
    
    cd ${S}

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			myconf="$myconf --prefix=${PREFIX} --host=${CHOST} --with-x --enable-mitshm --with-xinerama --with-qt-dir=${QTDIR}"
			# calculate dependencies separately from compiling, enables ccache to work on kde compiles
			myconf="$myconf --disable-dependency-tracking"
			use qtmt 	&& myconf="$myconf --enable-mt"
			[ -n "$DEBUG" ] && myconf="$myconf --enable-debug=full --with-debug"	|| myconf="$myconf --disable-debug --without-debug"
			debug-print "$FUNCNAME: myconf: set to ${myconf}"
			;;
		configure)
			debug-print-section configure
			debug-print "$FUNCNAME::configure: myconf=$myconf"

			# This can happen with e.g. a cvs snapshot			
			if [ ! -f "./configure" ]; then
			    for x in Makefile.cvs admin/Makefile.common; do
				if [ -f "$x" ] && [ -z "$makefile" ]; then makefile="$x"; fi
			    done
			    debug-print "$FUNCNAME: configure: generating configure script, running make -f $makefile"
			    make -f $makefile
			    [ -f "./configure" ] || die "no configure script found, generation unsuccessful"
			fi

			export PATH="${KDEDIR}/bin:${PATH}"
			./configure ${myconf} || die "died running ./configure, $FUNCNAME:configure"
			;;
		make)
			export PATH="${KDEDIR}/bin:${PATH}"
			debug-print-section make
			 emake || die "died running emake, $FUNCNAME:make"
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

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && kde_src_install all

	cd ${S}

	while [ "$1" ]; do

		case $1 in
			make)
				debug-print-section make
				make install DESTDIR=${D} destdir=${D} || die "died running make install, $FUNCNAME:make"
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
