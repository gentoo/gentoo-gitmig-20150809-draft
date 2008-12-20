# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/comix/comix-4.0.1.ebuild,v 1.1 2008/12/20 17:39:46 vanquirius Exp $

inherit toolchain-funcs gnome2 eutils

DESCRIPTION="A GTK image viewer specifically designed to handle comic books."
HOMEPAGE="http://comix.sourceforge.net"
SRC_URI="mirror://sourceforge/comix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="rar"
RDEPEND=">=dev-python/imaging-1.1.5
	>=dev-python/pygtk-2.12
	rar? ( || ( app-arch/unrar app-arch/rar ) )"

src_compile() {
	einfo "Nothing to be compiled."
}

src_install() {
	dodir /usr
	python install.py install --no-mime --dir "${D}"usr || die
	insinto /usr/share/mime/packages/
	doins "${S}"/mime/comix.xml || die
	insinto /etc/gconf/schemas/
	doins "${S}"/mime/comicbook.schemas || die
	dobin "${S}"/mime/comicthumb || die
	dodoc ChangeLog README || die
}
