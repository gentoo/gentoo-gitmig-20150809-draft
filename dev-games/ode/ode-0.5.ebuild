# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.5.ebuild,v 1.1 2004/06/02 06:46:42 mr_bones_ Exp $

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org"
SRC_URI="mirror://sourceforge/opende/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc
	virtual/x11
	virtual/glu
	virtual/opengl"

src_unpack() {
	unpack ${A}
	echo 'C_FLAGS+=$(E_CFLAGS)' >> "${S}/config/makefile.unix-gcc"
}

src_compile() {
	emake \
		-j1 \
		E_CFLAGS="${CFLAGS}" \
		PLATFORM=unix-gcc \
		|| die "emake failed"
}

src_install() {
	insinto /usr/include/ode
	doins include/ode/*.h || die "doins failed"
	dolib lib/libode.a lib/libdrawstuff.a || die "dolib failed"
	dodoc README CHANGELOG
}
