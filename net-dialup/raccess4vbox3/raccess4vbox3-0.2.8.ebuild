# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/raccess4vbox3/raccess4vbox3-0.2.8.ebuild,v 1.2 2004/11/21 18:48:59 mrness Exp $

inherit eutils

DESCRIPTION="DTMF support and utilities for net-dialup/vbox3"
SRC_URI="http://smarden.org/pape/vbox3/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/vbox3/${PN}/"

KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

RDEPEND="net-dialup/vbox3"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc Configuration INSTALL README
	dohtml doc/*.html
}
