# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smssend/smssend-3.3.ebuild,v 1.1 2005/05/15 19:49:33 mrness Exp $

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
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL \
	    License.txt NEWS README todo.txt
}

