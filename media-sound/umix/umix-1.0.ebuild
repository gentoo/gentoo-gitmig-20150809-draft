# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/umix/umix-1.0.ebuild,v 1.4 2004/04/08 04:39:57 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Program for adjusting soundcard volumes"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://umix.sf.net"

SLOT="0"
KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
IUSE="ncurses oss"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )"

src_compile() {
	local myconf
	use ncurses || myconf="--disable-ncurses"
	use oss || myconf="${myconf} --disable-oss"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog NEWS README TODO
}
