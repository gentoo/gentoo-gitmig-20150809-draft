# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/watchdog-5.9.ebuild,v 1.1 2010/11/29 10:12:21 dev-zero Exp $

DESCRIPTION="A software watchdog"
HOMEPAGE="http://sourceforge.net/projects/watchdog/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~m68k ~mips ~ppc ~s390 ~sh ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}

	dodoc AUTHORS README TODO NEWS ChangeLog
	docinto examples
	dodoc examples/*
}
