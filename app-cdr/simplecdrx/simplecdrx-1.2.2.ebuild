# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-1.2.2.ebuild,v 1.4 2003/09/05 22:57:44 msterret Exp $

DESCRIPTION="CD ripping/mastering"
HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"
SRC_URI="http://ogre.rocky-road.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc "
SLOT="0"
IUSE="gnome"

#todo: add blade encoder
DEPEND="media-sound/mad
	app-cdr/cdrtools
	app-cdr/cdrdao
	media-sound/cdparanoia
	media-sound/lame
	media-libs/libogg
	media-libs/libvorbis
	media-sound/mpg123
	virtual/x11
	=x11-libs/gtk+-1.2*
	dev-libs/glib
	media-libs/libao"

src_compile() {
	cp src/main.c src/main.c.orig
	sed -e 's:/usr/local/share:/usr/share:g' \
		src/main.c.orig >src/main.c || die
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	doman man/simplecdr-x.1

	insinto /usr/share/pixmaps
	doins pixmaps/simplecdr.xpm ${FILESDIR}/simplecdrx.png

	# Add the Gnome menu entry
	if [ `use gnome` ] ; then
		insinto /usr/share/gnome/apps/Applications/
		doins ${FILESDIR}/simplecdrx.desktop
	fi

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
