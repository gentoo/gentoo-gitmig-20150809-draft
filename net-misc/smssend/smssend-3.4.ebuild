# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smssend/smssend-3.4.ebuild,v 1.1 2004/12/16 07:12:13 absinthe Exp $

inherit eutils

DESCRIPTION="Universal SMS sender."
HOMEPAGE="http://zekiller.skytech.org/smssend_menu_en.html"
SRC_URI="http://zekiller.skytech.org/fichiers/smssend/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""
DEPEND=">=dev-libs/skyutils-2.7
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc
	virtual/libc"

RDEPEND=">=dev-libs/skyutils-2.7"

src_unpack() {
	unpack ${A}
	
	# Patch for Verizon Wireless support
	# absinthe@gentoo.org 12/16
	cd ${S}
	epatch ${FILESDIR}/${P}-verizon.diff
}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL \
	    License.txt NEWS README todo.txt
}
