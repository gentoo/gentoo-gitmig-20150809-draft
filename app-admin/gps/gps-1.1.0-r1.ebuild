# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gps/gps-1.1.0-r1.ebuild,v 1.11 2007/07/02 13:35:13 peper Exp $

inherit eutils

DESCRIPTION="Graphical (GTK+1.2) Process Statistics"
HOMEPAGE="http://gps.seul.org/"
SRC_URI="ftp://ftp.seul.org/pub/gps/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

RESTRICT="userpriv"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${P}-gentoo
}

src_install() {
	make DESTDIR="${D}" install || die

	doinitd "${FILESDIR}"/rgpsp

	dodoc TODO README* CHANGELOG

	doman rgpsp/rgpsp.1
	doman gps.1x


	insinto /etc
	newins rgpsp/sample.rgpsp.conf rgpsp.conf

	rm -rf "${D}"/usr/man "${D}"/usr/doc "${D}"/etc/rc.d
	rm -f "${D}"/usr/bin/rgpsp

	dosym /usr/bin/rgpsp_linux /usr/bin/rgpsp
}
