# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.06-r1.ebuild,v 1.2 2005/07/27 23:23:56 smithj Exp $

inherit eutils

IUSE=""

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/fireflies/"
SRC_URI="http://somewhere.fscked.org/fireflies/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-Make.include.in.patch
}

src_compile() {
	local myconf

	myconf="--with-bindir=/usr/lib/misc/xscreensaver
		--with-confdir=/usr/share/xscreensaver/config/"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc COPYING COMPILE README TODO
}
