# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ode/ode-0.03.ebuild,v 1.4 2003/03/29 04:10:19 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Open Dynamics Engine SDK"
SRC_URI="http://www.q12.org/ode/release/${P}.tgz"
HOMEPAGE="http://opende.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"

DEPEND=">=sys-apps/sed-4.0.5
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd ${S}/config
	sed -i "s,'PLATFORM=msvc','PLATFORM=unix-gcc'," user-settings
}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/include/ode
	insinto /usr/include/ode
	doins include/ode/*.h

	dolib lib/libode.a
	dolib lib/libdrawstuff.a

	dodoc README CHANGELOG LICENSE.TXT
}
