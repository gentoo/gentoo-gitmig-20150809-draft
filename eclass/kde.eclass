# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.78 2003/04/13 21:46:44 danarmak Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.

inherit base kde-functions
ECLASS=kde
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://www.kde.org/"

# deps on the build tools
if [ -n "$KDEBASE" -a -n "`use ppc`" -a "${PV//3.1}" != "$PV" ]; then
	DEPEND="$DEPEND >=sys-devel/automake-1.6.3"
else
	DEPEND="$DEPEND sys-devel/automake"
fi
DEPEND="$DEPEND sys-devel/autoconf sys-devel/make dev-lang/perl" # perl is used for makefile generation

# all kde apps need this one
newdepend "~kde-base/kde-env-3"

# overridden in other places like kde-dist, kde-source and some individual ebuilds
SLOT="0"

kde_src_unpack() {

	debug-print-function $FUNCNAME $*
	
	# call base_src_unpack, which implements most of the functionality and has sections,
	# unlike this function. The change from base_src_unpack to kde_src_unpack is thus
	# wholly transparent for ebuilds.
	base_src_unpack $*
	
	# kde-specific stuff stars here
	
	# fix the 'languageChange undeclared' bug group: touch all .ui files, so that the
	# makefile regenerate any .cpp and .h files depending on them.
	cd $S
	debug-print "$FUNCNAME: Searching for .ui files in $PWD"
	UIFILES="`find . -name '*.ui' -print`"
	debug-print "$FUNCNAME: .ui files found:"
	debug-print "$UIFILES"
	# done in two stages, because touch doens't have a silent/force mode
	if [ -n "$UIFILES" ]; then
		debug-print "$FUNCNAME: touching .ui files..."
		touch $UIFILES
	fi

	# shorthand for removing specified subdirectories fom the build process
	[ -n "$KDE_REMOVE_DIR" ] && kde_remove_dir $KDE_REMOVE_DIR

}

kde_src_compile() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && kde_src_compile all
    
	cd ${S}
	export kde_widgetdir="$KDEDIR/lib/kde3/plugins/designer"

	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build process
	# can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p $T/fakehome/.kde
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"	
	
	while [ "$1" ]; do

		case $1 in
			myconf)
				debug-print-section myconf
				myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-x --enable-mitshm --with-xinerama --with-qt-dir=${QTDIR} --enable-mt"
				# calculate dependencies separately from compiling, enables ccache to work on kde compiles
				myconf="$myconf --disable-dependency-tracking"
				# use debug is replacing $DEBUG
				if [ -n "$DEBUG" -o -n "`use debug`" ]; then
				    myconf="$myconf --enable-debug=full --with-debug"
				else
				    myconf="$myconf --disable-debug --without-debug"
				fi
				debug-print "$FUNCNAME: myconf: set to ${myconf}"
				;;
			configure)
				debug-print-section configure
				debug-print "$FUNCNAME::configure: myconf=$myconf"

				# rebuild configure script, etc
				# This can happen with e.g. a cvs snapshot			
				if [ ! -f "./configure" ]; then
					for x in Makefile.cvs admin/Makefile.common; do
						if [ -f "$x" ] && [ -z "$makefile" ]; then makefile="$x"; fi
					done
					if [ -f "$makefile" ]; then
						debug-print "$FUNCNAME: configure: generating configure script, running make -f $makefile"
						make -f $makefile
					fi
					[ -f "./configure" ] || die "no configure script found, generation unsuccessful"
				fi

				export PATH="${KDEDIR}/bin:${PATH}"
				
				# configure doesn't need to know about the other KDEs installed.
				# in fact, if it does, it sometimes tries to use the wrong dcopidl, etc.
				# due to the messed up way configure searches for things
				export KDEDIRS="${PREFIX}:${KDEDIR}"

				cd $S
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
				for doc in AUTHORS ChangeLog* README* COPYING NEWS TODO; do
					[ -f "$doc" ] && dodoc $doc
				done
				;;
	    	all)
				debug-print-section all
				kde_src_install make dodoc
				;;
		esac

	shift
	done

}

EXPORT_FUNCTIONS src_unpack src_compile src_install
