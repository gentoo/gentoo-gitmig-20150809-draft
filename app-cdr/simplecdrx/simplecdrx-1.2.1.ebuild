# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-1.2.1.ebuild,v 1.1 2002/11/03 19:10:41 agenkin Exp $

DESCRIPTION="CD ripping/mastering"
HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"
LICENSE="GPL-2"

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
		
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
IUSE="gnome"

SRC_URI="http://ogre.rocky-road.net/files/${P}.tar.bz2"
S=${WORKDIR}/${P}


src_compile() {

	cp src/main.c src/main.c.orig
	sed -e 's:/usr/local/share:/usr/share:g' \
		src/main.c.orig >src/main.c || die

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		|| die
	
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die


	# Add the Gnome menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/simplecdrx.png
		insinto /usr/share/gnome/apps/Applications/
		doins ${FILESDIR}/simplecdrx.desktop
	fi

	doman man/simplecdr-x.1

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
