# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.7-r3.ebuild,v 1.1 2002/11/14 17:06:11 leonardop Exp $

IUSE="gnome nls perl"

S=${WORKDIR}/${P}
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
		perl? ( sys-devel/perl )
		nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	
	use perl && myconf="${myconf} --with-perl"
	use nls  || myconf="${myconf} --disable-nls"
	
	econf \
		--with-autocomplet \
		${myconf} || die "./configure failed"
		
	emake || die "Compilation failed"

}

src_install () {
	einstall \
		pkgdatadir=${D}/usr/share/bluefish \
		pixmapsdir=${D}/usr/share/pixmaps || die "Installation failed"

	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/Development/
		doins data/bluefish.desktop
	fi

	dodoc ABOUT-NLS AUTHORS BUGS COPYING INSTALL NEWS README TODO
	mv manual ${D}usr/share/doc/${PF}
}
