# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-ddvcard/aqhbci-ddvcard-0.9.4_beta.ebuild,v 1.3 2004/12/27 01:35:44 kloeri Exp $

DESCRIPTION="DDV-Card plugin for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${PN/-/_}-${PV/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
IUSE="debug"
DEPEND="net-libs/aqhbci
	sys-libs/chipcard-client"
S=${WORKDIR}/${PN/-/_}-${PV/_/}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}
