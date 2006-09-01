# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/winefish/winefish-1.3.3.ebuild,v 1.4 2006/09/01 00:42:21 dang Exp $

inherit eutils fdo-mime

MY_PV=${PV/%[[:alpha:]]/}


DESCRIPTION="LaTeX editor based on Bluefish"
HOMEPAGE="http://winefish.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="spell"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libpcre-6.3
	spell? ( virtual/aspell-dict )"

#S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	econf --disable-update-databases || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc AUTHORS CHANGES README ROADMAP THANKS TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo "You need to emerge a TeX distribution to gain winfish's full capacity"
}
