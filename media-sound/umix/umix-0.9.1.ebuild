# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Sakari Lehtonen <sakari@ionstream.fi>
# $Header: /var/cvsroot/gentoo-x86/media-sound/umix/umix-0.9.1.ebuild,v 1.1 2002/07/14 10:31:26 phoenix Exp $

DESCRIPTION="Program for adjusting soundcard volumes"
SRC_URI="http://www.ionstream.fi/sakari/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ionstream.fi/sakari/umix/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	ncurses? ( >=sys-libs/ncurses-5.2 )
	gtk?     ( >=x11-libs/gtk+-2.0.0 )"

src_compile() {

	local myopts
	use ncurses || myopts="--disable-ncurses"
	use gtk     || myopts="${myopts} --disable-gtk"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/man \
		--host=${CHOST} \
		${myopts} || die

	emake || die
}

src_install() {

	make DESTDIR=${D} install

	dodoc AUTHORS ChangeLog NEWS README TODO
}
