# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.4.ebuild,v 1.4 2002/08/14 23:44:15 murphy Exp $

NAME="hotkeys"
S=${WORKDIR}/${P}
DESCRIPTION="Make use of extra buttons on newer keyboards."
SRC_URI="http://ypwong.org/hotkeys/hotkeys_0.5.4.tar.gz"
HOMEPAGE="http://ypwong.org/hotkeys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	virtual/glibc
	dev-libs/libxml2
	>=sys-libs/db-3.2.3
	x11-libs/xosd"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	zcat ${FILESDIR}/${P}-gentoo.diff.gz | patch -p0
}

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README TODO
}

