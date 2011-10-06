# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mcomix/mcomix-0.94.ebuild,v 1.2 2011/10/06 03:42:28 dirtyepic Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1

inherit distutils fdo-mime python

DESCRIPTION="A fork of comix, a GTK image viewer for comic book archives."
HOMEPAGE="http://mcomix.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rar"

RDEPEND="
	app-arch/unzip
	dev-python/pysqlite
	>=dev-python/imaging-1.1.5
	>=dev-python/pygtk-2.12
	rar? ( || ( app-arch/unrar app-arch/rar ) )
	!media-gfx/comix"
# TODO - if libunrar ever becomes available (bug #177402)
# we need it for passworded cbr archives

RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	distutils_src_install
	insinto /etc/gconf/schemas/
	doins "${S}"/mime/comicbook.schemas || die
	dobin "${S}"/mime/comicthumb || die
	dodoc ChangeLog README || die
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
