# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.7.ebuild,v 1.3 2002/07/07 02:23:04 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
        >=media-libs/imlib-1.9.10-r1
		perl? ( sys-devel/perl )"

src_compile() {

	local myconf
	if [ "`use perl`" ]
	then
		myconf="$myconf --with-perl"
	fi
	
	./configure --prefix=/usr \
		--host=${CHOST} \
		--with-autocomplet \
		$myconf || die
		
	emake || die

}

src_install () {
	
	makefiles=`find . -name Makefile`
	for f in $makefiles; do
	    mv $f $f.orig
    	sed -e 's#$(prefix)#$(DESTDIR)$(prefix)#' \
			-e 's#${prefix}#$(DESTDIR)${prefix}#' \
			-e 's#/usr/share/pixmaps#$(DESTDIR)$(prefix)/share/pixmaps#' \
			$f.orig > $f
	done

	make DESTDIR=${D} install || die
    dodoc ABOUT-NLS AUTHORS BUGS COPYING INSTALL NEWS README TODO
	mv manual ${D}usr/share/doc/${PF}
}

