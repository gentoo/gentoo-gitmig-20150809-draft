# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.91.ebuild,v 1.3 2003/03/30 17:14:35 mholzer Exp $

DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="gnome png python"

DEPEND=">=x11-libs/gtk+-2.0.0
		>=x11-libs/pango-1.1.5
		>=dev-libs/libxml2-2.3.9
		>=media-libs/freetype-2.0.9
		>=dev-util/intltool-0.21
		png? ( media-libs/libpng
			media-libs/libart_lgpl )
		gnome? ( gnome-base/gnome-libs )
		python? ( >=dev-lang/python-2.0
				dev-python/pygtk )"
		
RDEPEND="${DEPEND}"
		
src_compile() {
	local myconf

	use gnome && myconf="--enable-gnome" \
		|| myconf="--disable-gnome"

	use python && myconf="${myconf} --with-python"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
