# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.9.ebuild,v 1.2 2003/02/18 13:11:17 lu_zero Exp $

#MY_P=${PN}-gtk2-${PV}
#S=${WORKDIR}/${MY_P}
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
SLOT="0"
IUSE="nls perl"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=media-libs/freetype-2.0.9
	>=media-libs/gdk-pixbuf-0.18
	dev-libs/libpcre
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
	cd ${S}
	sed -e "s:"/usr/share/pixmaps/b":"${D}/usr/share/pixmaps/b":g" Makefile \
		> Makefile.new
	cp Makefile.new Makefile
	cd data 
	sed -e "s:"/usr/share":"${D}/usr/share":g" Makefile \
		> Makefile.new
	cp Makefile.new Makefile
	dodir /usr/bin
	dodir /usr/share/pixmaps
	cd ${S}
	einstall datadir=${D}/usr/share \
		pkgdatadir=${D}/usr/share/bluefish 
#		pixmapsdir=${D}/usr/share/pixmap \
}
