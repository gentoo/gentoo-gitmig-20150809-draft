# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.8.ebuild,v 1.5 2003/03/11 21:11:44 seemant Exp $

MY_P=${PN}-gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${MY_P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
SLOT="0"
IUSE="nls perl"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=media-libs/freetype-2.0.9
	>=media-libs/gdk-pixbuf-0.18
	dev-libs/libpcre
	perl? ( dev-lang/perl )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf="--with-autocomplet"
	use perl && myconf="${myconf} --with-perl"
	use nls  || myconf="${myconf} --disable-nls"
	econf ${myconf}

	emake || die

}

src_install() {
	einstall \
		datadir=${D}/usr/share \
		pkgdatadir=${D}/usr/share/bluefish
}
