# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/raccess4vbox3/raccess4vbox3-0.2.8-r1.ebuild,v 1.3 2005/05/15 16:57:47 mrness Exp $

inherit eutils

DESCRIPTION="DTMF support and utilities for net-dialup/vbox3"
SRC_URI="http://smarden.org/pape/vbox3/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/vbox3/${PN}/"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="|| ( net-mail/qprint net-mail/metamail app-text/recode app-emacs/vm )
	net-dialup/vbox3"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-qp-encode.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc Configuration INSTALL README
	dohtml doc/*.html
}
