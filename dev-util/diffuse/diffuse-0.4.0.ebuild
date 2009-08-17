# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffuse/diffuse-0.4.0.ebuild,v 1.1 2009/08/17 17:02:00 grozin Exp $

EAPI="2"

inherit distutils fdo-mime

DESCRIPTION="A graphical tool to compare and merge text files"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk"
# file collision, bug #279018
DEPEND="!sci-chemistry/tinker"

src_compile() {
	:
}

src_install() {
	${python} install.py \
		--prefix=/usr \
		--files-only \
		--destdir="${D}" \
		|| die "Installation failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
}
