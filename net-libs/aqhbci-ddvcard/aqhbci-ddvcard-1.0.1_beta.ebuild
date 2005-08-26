# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-ddvcard/aqhbci-ddvcard-1.0.1_beta.ebuild,v 1.3 2005/08/26 18:54:59 agriffis Exp $

DESCRIPTION="DDV-Card plugin for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-0.9.6_beta
	>=sys-libs/libchipcard-0.9.9_beta"
S=${WORKDIR}/${P/_/}
MAKEOPTS="-j1"

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}
