# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/getdelta/getdelta-0.6.9.ebuild,v 1.1 2005/03/13 07:19:15 genstef Exp $

DESCRIPTION="dynamic deltup client"
RESTRICT="nomirror"
HOMEPAGE="http://linux01.gwdg.de/~nlissne/"
SRC_URI="http://linux01.gwdg.de/~nlissne/${P}.tar.bz2"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 -amd64"

RDEPEND="app-portage/deltup"

src_install () {
	dobin ${WORKDIR}/getdelta.sh
}

pkg_postinst() {
	einfo "You need to put"
	einfo "FETCHCOMMAND=\"/usr/bin/getdelta.sh \\\${URI}\""
	einfo "into your /etc/make.conf to make use of getdelta"
}
