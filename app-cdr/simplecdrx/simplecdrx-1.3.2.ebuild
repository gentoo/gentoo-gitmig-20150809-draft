# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-1.3.2.ebuild,v 1.9 2004/10/05 11:22:56 pvdabeel Exp $

DESCRIPTION="CD ripping/mastering"
HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"
SRC_URI="http://ogre.rocky-road.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

#todo: add blade encoder
DEPEND="media-sound/madplay
	app-cdr/cdrtools
	app-cdr/cdrdao
	media-sound/cdparanoia
	media-sound/lame
	media-libs/libogg
	media-libs/libvorbis
	virtual/mpg123
	virtual/x11
	=x11-libs/gtk+-1.2*
	dev-libs/glib
	media-libs/libao"

src_compile() {
	sed -i -e 's:/usr/local/share:/usr/share:g' src/main.c.orig
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	doman man/simplecdrx.1

	insinto /usr/share/pixmaps
	doins pixmaps/simplecdr.xpm ${FILESDIR}/simplecdrx.png

	# Add the menu entry
	insinto /usr/share/applications/
	doins ${FILESDIR}/simplecdrx.desktop

	dodoc AUTHORS ChangeLog INSTALL README
}
