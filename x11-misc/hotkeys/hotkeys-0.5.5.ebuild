# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.5.ebuild,v 1.1 2002/09/11 19:06:31 aliz Exp $

NAME="hotkeys"
S=${WORKDIR}/${P}
DESCRIPTION="Make use of extra buttons on newer keyboards."
SRC_URI="http://ypwong.org/hotkeys/${P}.tar.bz2"
HOMEPAGE="http://ypwong.org/hotkeys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	virtual/glibc
	dev-libs/libxml2
	>=sys-libs/db-3.2.3
	=x11-libs/xosd-0.7.0"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-xosd-lib=/usr/lib/xosd-0.7.0 \
		--with-xosd-inc=/usr/include/xosd-0.7.0 \
		--sysconfdir=/etc || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README TODO
}

