# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/comix/comix-3.6.4-r1.ebuild,v 1.4 2008/04/06 20:21:28 dertobi123 Exp $

inherit toolchain-funcs gnome2 eutils

DESCRIPTION="A GTK image viewer specifically designed to handle comic books."
HOMEPAGE="http://comix.sourceforge.net"
SRC_URI="mirror://sourceforge/comix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="doc rar"
RDEPEND=">=dev-python/pygtk-2.8.0
	rar? ( app-arch/unrar )
	>=dev-python/imaging-1.1.4"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-command-argument-closure.patch
	epatch "${FILESDIR}"/${P}-tmpfile.patch
}

src_compile() {
	einfo "Nothing to be compiled."
}

src_install() {
	dodir /usr
	python install.py install --no-mime --installdir "${D}"usr 1>/dev/null || die
	insinto /usr/share/mime/packages/
	doins "${S}"/mime/comix.xml
	insinto /etc/gconf/schemas/
	doins "${S}"/mime/comicbook.schemas
	dobin "${S}"/mime/comicthumb
	dodoc ChangeLog README
}
