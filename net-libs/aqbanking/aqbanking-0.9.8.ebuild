# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-0.9.8.ebuild,v 1.5 2005/01/02 18:19:45 chriswhite Exp $

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE="debug"
DEPEND=">=sys-libs/gwenhywfar-1.2"
S=${WORKDIR}/${P}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
