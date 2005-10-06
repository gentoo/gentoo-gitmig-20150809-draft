# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smssend/smssend-3.3.ebuild,v 1.2 2005/10/06 06:01:18 mrness Exp $

DESCRIPTION="Universal SMS sender"
HOMEPAGE="http://zekiller.skytech.org/smssend_menu_en.html"
SRC_URI="http://zekiller.skytech.org/fichiers/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/skyutils-2.6
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc
	virtual/libc"
RDEPEND=">=dev-libs/skyutils-2.6"

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README todo.txt
}
