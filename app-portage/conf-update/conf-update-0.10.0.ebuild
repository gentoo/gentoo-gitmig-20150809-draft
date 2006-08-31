# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/conf-update/conf-update-0.10.0.ebuild,v 1.2 2006/08/31 20:51:19 blubb Exp $

DESCRIPTION="${PN} is a ncurses-based config management utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
		dev-libs/openssl
		sys-libs/ncurses"
DEPEND="dev-util/pkgconfig
		${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s/\$Rev:.*\\$/${PVR}/" conf-update.h
	sed -i -e "s:-Wno-pointer-sign::g" Makefile
}

src_install() {
	into /usr
	dosbin ${PN}

	insinto /etc
	doins ${PN}.conf

	doman *.1
}
