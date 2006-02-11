# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/comix/comix-2.8.ebuild,v 1.1 2006/02/11 18:10:46 vanquirius Exp $

inherit toolchain-funcs

DESCRIPTION="A GTK image viewer specifically designed to handle comic books."
HOMEPAGE="http://comix.sourceforge.net"
SRC_URI="mirror://sourceforge/comix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rar"
RDEPEND=">=dev-python/pygtk-2.6
	rar? ( app-arch/unrar )
	>=dev-python/imaging-1.1.4"

src_install() {
	dodir usr
	python install.py install --no-mime --installdir "${D}"usr 1>/dev/null
	insinto /usr/share/mime/packages/
	doins "${S}"/mime/comix.xml
	dodoc ChangeLog README
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}
