# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.039.ebuild,v 1.1 2003/07/20 05:13:41 vapier Exp $

inherit gcc

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://opende.sourceforge.net/"
SRC_URI="mirror://sourceforge/opende/${P}.tgz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND="virtual/opengl"

pkg_setup() {
	#this (version of) package fails when built with gcc-3.3*
	if [ "`gcc-version`" == "3.3" ]; then
		ewarn "Unfortunately this version of the package cannot (yet) be built with >=gcc-3.3"
		ewarn "You can install an older version of gcc and then use gcc-config to switch"
		ewarn "compiler version for the duration of the build."
		ewarn "Alternatively please see #22071 for more options."
		ewarn "We apologise for the inconvinience."
		die
	fi
}

src_unpack() {
	unpack ${A}
	echo "C_FLAGS+=${CFLAGS}" >> ${S}/config/makefile.unix-gcc
}

src_compile() {
	make \
		CFLAGS="${CFLAGS} -O" \
		PLATFORM=unix-gcc \
		|| die
}

src_install() {
	insinto /usr/include/ode
	doins include/ode/*.h
	dolib lib/libode.a lib/libdrawstuff.a
	dodoc README CHANGELOG
}
