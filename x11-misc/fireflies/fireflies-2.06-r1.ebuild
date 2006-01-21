# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.06-r1.ebuild,v 1.6 2006/01/21 11:35:42 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/fireflies/"
SRC_URI="http://somewhere.fscked.org/fireflies/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="|| ( media-libs/mesa virtual/x11 )
	media-libs/libsdl"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-libs/libX11 )
	virtual/x11 )"

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
	dodoc COMPILE README TODO
}
