# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-gui/guile-gui-0.2.ebuild,v 1.5 2009/04/20 20:56:15 maekke Exp $

DESCRIPTION="Guile Scheme code that aims to implement a graphical user interface"
HOMEPAGE="http://www.ossau.uklinux.net/guile/"
SRC_URI="http://www.ossau.uklinux.net/guile/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
RDEPEND="dev-scheme/guile
	x11-libs/guile-gtk"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc ${S}/README
}
