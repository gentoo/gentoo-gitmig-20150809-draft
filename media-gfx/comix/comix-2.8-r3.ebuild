# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/comix/comix-2.8-r3.ebuild,v 1.2 2006/03/25 16:07:29 vanquirius Exp $

inherit toolchain-funcs gnome2

DESCRIPTION="A GTK image viewer specifically designed to handle comic books."
HOMEPAGE="http://comix.sourceforge.net"
SRC_URI="mirror://sourceforge/comix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc rar"
RDEPEND=">=dev-python/pygtk-2.6
	rar? ( app-arch/unrar )
	>=dev-python/imaging-1.1.4"

src_compile() {
	einfo "Nothing to be compiled."
}

src_install() {
	dodir /usr
	python install.py install --no-mime --installdir "${D}"usr 1>/dev/null
	insinto /usr/share/mime/packages/
	doins "${S}"/mime/comix.xml
	insinto /etc/gconf/schemas/
	doins "${S}"/mime/comicbook.schemas
	dobin "${S}"/mime/comicthumb
	dodoc ChangeLog README
}
