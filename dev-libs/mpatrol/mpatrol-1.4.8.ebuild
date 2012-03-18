# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mpatrol/mpatrol-1.4.8.ebuild,v 1.18 2012/03/18 15:40:57 armin76 Exp $

EAPI=1

IUSE="X"

S=${WORKDIR}/${PN}
DESCRIPTION="A link library for controlling and tracing dynamic memory allocation. Attempts to diagnose run-time errors that are caused by misuse of dynamically allocated memory. Simple integration via a single header."
SRC_URI="http://www.cbmamiga.demon.co.uk/mpatrol/files/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.cbmamiga.demon.co.uk/mpatrol/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# To use X, mpatrol requires Motif
DEPEND="X? ( >=x11-libs/openmotif-2.3:0 )"
RDEPEND="${DEPEND}
	!dev-lang/mercury"

src_compile() {
	cd $S/build/unix
	mv Makefile Makefile.orig
	sed 's:^OFLAGS.= -O3:OFLAGS = ${OPT_FLAGS}:' < Makefile.orig > Makefile
	rm Makefile.orig

	if use X; then
		mv Makefile Makefile.orig
		sed 's:^GUISUP.= false:GUISUP = true:' < Makefile.orig > Makefile
		rm Makefile.orig

		env OPT_FLAGS="$CFLAGS" emake all || die "Failed to complete make (with X)"
		echo "Completed with X"
	else
		env OPT_FLAGS="$CFLAGS" emake all || die "Failed to complete make (without X)"
		echo "Completed without X"
	fi
}

# **
# ** The install is straightforward, but a bit on the odd side. The author
# ** gives a list of things that need to be done, rather than attempt to
# ** make an install target. --nj
# **
src_install () {
	cd $S/build/unix
	dobin mleak mpatrol mprof mptrace
	dolib.so lib*.so.*
	dolib.a  lib*.a

	# Each lib needs a symlink from the .so level
	for L in lib*.so.*; do
		dosym $L /usr/lib/`echo $L | sed 's:^\([^\.]*\.so\).*:\1:'`
	done

	insinto /
	cd ../../bin
	dobin *

	cd ../src
	insinto /usr/include/
	doins mpatrol.h mpalloc.h mpdebug.h

	cd ../tools
	insinto /usr/include/mpatrol
	doins *.h

	cd ../man
	doman man?/*

	cd ../doc
	dodoc mpatrol.html mpatrol.dvi mpatrol.txt refcard.dvi refcard.tex source.tex
	doinfo mpatrol.info
	insinto /usr/share/doc/$PF/images
	doins images/*.jpg images/*.eps

	cd ../
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS VERSION pkg/lsm/*lsm
}

pkg_postinst() {
	echo "***"
	echo "*** Please review the documentation in /usr/share/doc/$PF"
	echo "***"
	echo
}
