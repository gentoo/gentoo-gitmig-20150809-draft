# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/raccess4vbox3/raccess4vbox3-0.2.8-r1.ebuild,v 1.1 2005/05/15 11:18:50 mrness Exp $

inherit eutils

DESCRIPTION="DTMF support and utilities for net-dialup/vbox3"
SRC_URI="http://smarden.org/pape/vbox3/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/vbox3/${PN}/"

KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="|| ( net-mail/qprint net-mail/metamail app-text/recode )
	net-dialup/vbox3"

src_compile() {
	#set the Quoted-Printable transformation (#92530)
	if has_version net-mail/qprint ; then
		QP_ENCODE="qprint -e"
	elif has_version net-mail/metamail ; then
		QP_ENCODE="mimencode -q"
	else
		QP_ENCODE="recode ../qp"
	fi
	sed -i -e "s:qp-encode:${QP_ENCODE}:" ${S}/bin/vboxmail

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc Configuration INSTALL README
	dohtml doc/*.html
}
