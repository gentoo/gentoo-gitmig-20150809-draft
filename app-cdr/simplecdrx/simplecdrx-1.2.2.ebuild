# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-1.2.2.ebuild,v 1.12 2006/01/15 02:59:22 metalgod Exp $

DESCRIPTION="CD ripping/mastering"
HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"
SRC_URI="http://ogre.rocky-road.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE="gnome"

#todo: add blade encoder
DEPEND="media-sound/madplay
	app-cdr/cdrtools
	app-cdr/cdrdao
	media-sound/cdparanoia
	media-sound/lame
	media-libs/libogg
	media-libs/libvorbis
	virtual/mpg123
	=x11-libs/gtk+-1.2*
	dev-libs/glib
	media-libs/libao"

src_compile() {
	cp src/main.c src/main.c.orig
	sed -e 's:/usr/local/share:/usr/share:g' \
		src/main.c.orig >src/main.c || die
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	doman man/simplecdr-x.1

	insinto /usr/share/pixmaps
	doins pixmaps/simplecdr.xpm ${FILESDIR}/simplecdrx.png

	# Add the Gnome menu entry
	if use gnome ; then
		insinto /usr/share/gnome/apps/Applications/
		doins ${FILESDIR}/simplecdrx.desktop
	fi

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
