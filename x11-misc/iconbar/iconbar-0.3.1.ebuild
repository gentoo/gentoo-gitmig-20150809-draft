# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iconbar/iconbar-0.3.1.ebuild,v 1.2 2003/09/05 23:29:05 msterret Exp $

DESCRIPTION="e17 iconbar as a standalone package"
HOMEPAGE="http://www.rephorm.com/rephorm/code/iconbar/"
SRC_URI="http://www.rephorm.com/files/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/ebits-1.0.1.2003*
	>=media-libs/imlib2-1.0.6.2003*
	>=dev-libs/eet-0.0.1.2003*
	>=x11-libs/eprog-0.0.0.2003*"

S=${WORKDIR}/${PN}

src_compile() {
	cp build.sh{,.old}
	sed "s:^gcc :gcc ${CFLAGS} :" \
		build.sh.old > build.sh
	./build.sh || die
}

src_install() {
	dobin src/iconbar{,_icon_make} ${FILESDIR}/iconbar_install
	dodir /usr/share/${PN}
	mv data/* ${D}/usr/share/${PN}/
}
