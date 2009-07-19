# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffuse/diffuse-0.3.4.ebuild,v 1.1 2009/07/19 15:27:31 grozin Exp $
EAPI=2
inherit distutils fdo-mime
DESCRIPTION="A graphicsl tool to compare and merge text files"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-python/pygtk"

src_compile() {
	true
}

src_install() {
	${python} install.py \
		--prefix=/usr \
		--files-only \
		--destdir="${D}"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
