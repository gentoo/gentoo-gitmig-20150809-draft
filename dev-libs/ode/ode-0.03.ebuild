# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ode/ode-0.03.ebuild,v 1.2 2002/11/12 00:11:46 george Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Open Dynamics Engine SDK"
SRC_URI="http://www.q12.org/ode/release/${P}.tgz"
HOMEPAGE="http://www.q12.org/ode/"

LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND="virtual/opengl"

src_unpack() {
	unpack ${A}
	cd ${S}/config
	sed s,'PLATFORM=msvc','PLATFORM=unix-gcc', user-settings >user-settings.gcc || die
	mv user-settings.gcc user-settings || die
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

