# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cfe/cfe-0.12.ebuild,v 1.2 2005/07/22 18:13:42 dholm Exp $

inherit eutils

DESCRIPTION="Console font editor"
# the homepage is missing, so if you find new location please let us know
HOMEPAGE="http://lrn.ru/~osgene/"
SRC_URI="http://download.uhulinux.hu/pub/pub/mirror/http:/lrn.ru/~osgene/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	sed -i -e "s/CFLAGS=\".*\"/CFLAGS=\"${CFLAGS}\"/" configure || die
	econf || die
	emake || die
}

src_install() {
	dobin cfe
	doman cfe.1
	dodoc ChangeLog INSTALL THANKS dummy.fnt
}
