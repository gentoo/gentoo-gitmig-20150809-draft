# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/conf-update/conf-update-0.9.ebuild,v 1.1 2006/08/20 10:15:59 blubb Exp $

DESCRIPTION="${PN} is a ncurses-based config management utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
		dev-libs/openssl
		sys-libs/ncurses"
DEPEND="dev-util/pkgconfig
		${RDEPEND}"

src_compile() {
	emake
}

src_install() {
	into /usr
	dosbin ${PN}

	insinto /etc
	doins ${PN}.conf

	doman *.1
}
