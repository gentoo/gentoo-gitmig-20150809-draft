# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xoo/xoo-0.7.ebuild,v 1.1 2006/06/14 17:21:39 yvasilev Exp $

DESCRIPTION="Xoo is a graphical wrapper around xnest. You can make Xnest look like a particular device's display and set up buttons on that device."
HOMEPAGE="http://projects.o-hand.com/xoo"
SRC_URI="http://projects.o-hand.com/sources/xoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="gnome"

DEPEND="gnome? ( gnome-base/gconf )
	gnome-base/libglade
	|| ( (  x11-libs/libXtst
		x11-base/xorg-server )
		virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix default Xnest binary path.
	sed -e "s:/usr/X11R6/bin/Xnest:$(which Xnest):" -i src/main.c || die "sed failed."
}

src_compile() {
	econf $(use_enable gnome gconf) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"

	dodoc AUTHORS Changelog INSTALL NEWS README TODO
}
