# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/vbox3/vbox3-0.1.9.ebuild,v 1.1 2004/11/21 18:23:25 mrness Exp $

inherit eutils libtool

DESCRIPTION="ISDN voice response system"
SRC_URI="http://smarden.org/pape/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/${PN}/"

KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="virtual/libc
	sys-libs/ncurses
	dev-lang/tcl"
RDEPEND="${DEPEND}
	net-dialup/isdn4k-utils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/makefile-${PV}.patch || die "failed to patch makefile"
	elibtoolize
}

src_install() {
	keepdir /var/log/vbox
	einstall || die "make install failed"
	dosym vboxgetty /usr/sbin/vboxputty

	dodoc AUTHORS CHANGES README doc/INSTALL
	dohtml doc/*.html
	doman debian/*.8

	# install logrotate configs
	insinto /etc/logrotate.d
	newins ${FILESDIR}/vbox3.logrotate vbox3
}
