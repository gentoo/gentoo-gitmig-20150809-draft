# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-1.0.2_beta.ebuild,v 1.1 2005/01/23 01:44:57 hanno Exp $

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug"
DEPEND=">=sys-libs/gwenhywfar-1.4
	app-misc/ktoblzcheck"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf `use_enable debug` || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
