# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.12.0-r1.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

DESCRIPTION="multiplayer strategy game (Civilization Clone)"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${P}.tar.bz2"
HOMEPAGE="http://www.freeciv.org/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	|| (
		gtk? ( =x11-libs/gtk+-1.2*
			>=media-libs/imlib-1.9.10-r1 )
		x11-libs/xaw
	)"

src_compile() {
	# standard options
	local OPTIONS
	OPTIONS="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}"

	if [ -z "`use gtk`" ]; then
		OPTIONS="${OPTIONS} --enable-client=xaw --with-xaw3d"
	fi
	if [ -z "`use nls`" ]; then
		OPTIONS="${OPTIONS} --disable-nls"
	fi

	./configure ${OPTIONS} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	if [ -z "`use gtk`" ]; then
		/bin/install -D -m 644 ${S}/data/Freeciv ${D}/usr/X11R6/lib/X11/app-defaults/Freeciv
	fi
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog HOWTOPLAY INSTALL NEWS PEOPLE README README.* TODO freeciv_hackers_guide.txt
}
