# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-2002.06.23.ebuild,v 1.2 2002/08/02 05:05:01 seemant Exp $

MY_PV=`echo ${PV} | sed -e 's/\./-/g'`
S=${WORKDIR}/${PN}-gtk2
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/snapshots/${PN}-gtk2port-${MY_PV}.tgz"
HOMEPAGE="http://bluefish.openoffice.nl/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=media-libs/freetype-2.0.9
	>=media-libs/gdk-pixbuf-0.18
	perl? ( sys-devel/perl )
	nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}"

src_compile() {

	local myconf
	use perl && myconf="${myconf} --with-perl"
	use nls  || myconf="${myconf} --disable-nls"
	
	./configure 	\
		--prefix=/usr \
		--mandir=/usr/share/man	\
		--host=${CHOST} \
		--with-autocomplet \
		${myconf} || die
		
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

	make 	\
		DESTDIR=${D}	\
		mandir=${D}/usr/share/man	\
		install || die

	dodoc ABOUT-NLS AUTHORS BUGS COPYING INSTALL NEWS README TODO
	mv manual ${D}usr/share/doc/${PF}
}
