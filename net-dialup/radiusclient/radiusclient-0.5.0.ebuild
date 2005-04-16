# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient/radiusclient-0.5.0.ebuild,v 1.1 2005/04/16 23:14:32 mrness Exp $

inherit eutils

MY_P="${PN}-ng-${PV}"

DESCRIPTION="A library for writing RADIUS clients accompanied with several client utilities."
HOMEPAGE="http://developer.berlios.de/projects/radiusclient-ng/"
SRC_URI="http://download.berlios.de/${PN}-ng/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pkgsysconfdir-install.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
