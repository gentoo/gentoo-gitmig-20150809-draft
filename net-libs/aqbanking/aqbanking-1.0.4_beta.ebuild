# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-1.0.4_beta.ebuild,v 1.3 2005/02/14 17:15:31 blubb Exp $

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="debug"
DEPEND=">=sys-libs/gwenhywfar-1.7.2
	app-misc/ktoblzcheck"
S=${WORKDIR}/${P/_/}
MAKEOPTS="-j1"

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
