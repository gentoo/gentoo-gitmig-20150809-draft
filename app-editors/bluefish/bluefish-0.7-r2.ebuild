# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.7-r2.ebuild,v 1.14 2002/12/09 04:17:38 manson Exp $

DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "
SLOT="0"
IUSE="nls perl"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	perl? ( sys-devel/perl )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf="--with-autocomplet"
	use perl && myconf="${myconf} --with-perl"
	use nls  || myconf="${myconf} --disable-nls"
	econf ${myconf}

	emake || die
}

src_install() {
	makefiles=`find . -name Makefile`
	for f in $makefiles; do
	    mv $f $f.orig
		sed -e 's#$(prefix)#$(DESTDIR)$(prefix)#' \
			-e 's#${prefix}#$(DESTDIR)${prefix}#' \
			-e 's#/usr/share/pixmaps#$(DESTDIR)$(prefix)/share/pixmaps#' \
			$f.orig > $f
	done

	make \
		DESTDIR=${D} \
		mandir=${D}/usr/share/man \
		install || die

	dodoc ABOUT-NLS AUTHORS BUGS COPYING INSTALL NEWS README TODO
	mv manual ${D}usr/share/doc/${PF}
}
