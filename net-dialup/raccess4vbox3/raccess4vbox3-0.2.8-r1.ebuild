# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/raccess4vbox3/raccess4vbox3-0.2.8-r1.ebuild,v 1.5 2006/03/16 20:26:05 mrness Exp $

inherit eutils

DESCRIPTION="DTMF support and utilities for net-dialup/vbox3"
SRC_URI="http://smarden.org/pape/vbox3/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/vbox3/${PN}/"

KEYWORDS="~amd64 x86"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="|| ( net-mail/qprint net-mail/metamail app-text/recode app-emacs/vm )
	net-dialup/vbox3"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-qp-encode.patch"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc Configuration README
	dohtml doc/*.html
}
