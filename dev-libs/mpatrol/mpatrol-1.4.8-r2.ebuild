# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mpatrol/mpatrol-1.4.8-r2.ebuild,v 1.2 2007/07/12 02:25:34 mr_bones_ Exp $

inherit eutils flag-o-matic

IUSE="X"

DESCRIPTION="A link library for controlling and tracing dynamic memory allocation. Attempts to diagnose run-time errors that are caused by misuse of dynamically allocated memory. Simple integration via a single header."
SRC_URI="http://www.cbmamiga.demon.co.uk/mpatrol/files/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.cbmamiga.demon.co.uk/mpatrol/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
S="${WORKDIR}/${PN}"

# To use X, mpatrol requires Motif
DEPEND="X? ( x11-libs/openmotif )
		virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch "${FILESDIR}"/${PN}-1.4.8-soname.patch || die "patching failed"

	cd ${S}/src
	# [Bug 176592] textrel fix for dev-libs/mpatrol
	epatch "${FILESDIR}"/${PN}-textrel-fix.patch || die "patching failed"

	sed -i \
	    -e 's:#define MP_SYMBOL_LIBS , MP_LIBNAME(bfd), MP_LIBNAME(iberty):#define MP_SYMBOL_LIBS , MP_LIBNAME(bfd):' config.h \
	        || die "sed config.h failed"

	cd ${S}/build/unix
	sed -i \
	    -e 's:^OFLAGS.= -O3:OFLAGS = ${OPT_FLAGS}:' Makefile \
	        || die "sed Makefile for CFLAGS failed"

	sed -i \
	    -e 's:$(LD) $(LDFLAGS) -o $@ $(SHARED_MPTOBJS):$(LD) $(LDFLAGS) -liberty -o $@ $(SHARED_MPTOBJS):' Makefile \
	        || die "sed Makefile for fixing -libiberty failed"

	use X && sed -i \
		    -e 's:^GUISUP.= false:GUISUP = true:' Makefile \
			|| die "sed Makefile for GUISUP failed"

}

src_compile() {
	cd ${S}/build/unix
	STRIPPROG=true OPT_FLAGS="$CFLAGS -Wa,--noexecstack" emake all || die "emake failed"
}

# **
# ** The install is straightforward, but a bit on the odd side. The author
# ** gives a list of things that need to be done, rather than attempt to
# ** make an install target. --nj
# **
src_install () {
	cd ${S}/build/unix
	dobin mleak mpatrol mprof mptrace
	dolib.so lib*.so.*
	dolib.a  lib*.a

	# Each lib needs a symlink from the .so level
	#for L in lib*.so.*; do
	#	dosym $L /usr/lib/`echo $L | sed 's:^\([^\.]*\.so\).*:\1:'`
	#done

	insinto /usr
	cd ${S}/bin
	dobin *

	insinto /usr/include/
	cd ${S}/src
	doins mpatrol.h mpalloc.h mpdebug.h

	insinto /usr/include/mpatrol
	doins ${S}/tools/*.h

	doman ${S}/man/man?/*

	cd ${S}
	dodoc AUTHORS ChangeLog NEWS README THANKS VERSION pkg/lsm/*lsm

	cd ${S}/doc
	dodoc *.dvi *.ps *.pdf *.txt
	doinfo mpatrol.info
	dohtml mpatrol.html

	docinto images
	dodoc images/*.{eps,pdf}

	insinto /usr/share/doc/${F}/html/images
	doins images/*.jpg
}

pkg_postinst() {
	elog " Please review the documentation in /usr/share/doc/$PF"
}
