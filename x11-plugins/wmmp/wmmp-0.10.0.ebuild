# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmp/wmmp-0.10.0.ebuild,v 1.1 2004/03/14 19:03:39 mholzer Exp $

IUSE=""

MY_P=${P/wm/WM}
DESCRIPTION="A Window Maker dock app client for Music Player Daemon(media-sound/mpd)"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.musicpd.org"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~amd64"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf
	myconf="--with-gnu-ld"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install () {
	emake install DESTDIR=${D} || die

	dodoc AUTHORS COPYING INSTALL README THANKS TODO
}
