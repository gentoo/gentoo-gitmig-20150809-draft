# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.039.ebuild,v 1.5 2004/02/20 07:44:01 mr_bones_ Exp $

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://opende.sourceforge.net/"
SRC_URI="mirror://sourceforge/opende/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/opengl"

src_unpack() {
	unpack ${A}
	echo "C_FLAGS+=${CFLAGS}" >> ${S}/config/makefile.unix-gcc
}

src_compile() {
	emake \
		-j1 \
		CFLAGS="${CFLAGS} -O" \
		PLATFORM=unix-gcc \
		|| die "emake failed"
}

src_install() {
	insinto /usr/include/ode
	doins include/ode/*.h
	dolib lib/libode.a lib/libdrawstuff.a
	dodoc README CHANGELOG
}
