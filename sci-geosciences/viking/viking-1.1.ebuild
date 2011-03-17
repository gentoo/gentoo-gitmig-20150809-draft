# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/viking/viking-1.1.ebuild,v 1.1 2011/03/17 12:12:16 dilfridge Exp $

EAPI=4

DESCRIPTION="GPS data editor and analyzer"
HOMEPAGE="http://viking.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="gps nls"
KEYWORDS="~amd64 ~ppc ~x86"

COMMONDEPEND="dev-libs/expat
	dev-libs/glib:2
	net-misc/curl
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	gps? ( sci-geosciences/gpsd )
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMONDEPEND}
	sci-geosciences/gpsbabel"
DEPEND="${COMMONDEPEND}
	app-text/gnome-doc-utils
	app-text/rarian
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--enable-google \
		--enable-terraserver \
		--enable-expedia \
		--enable-openstreetmap \
		--enable-bluemarble \
		--enable-geonames \
		--enable-geocaches \
		--enable-spotmaps \
		--disable-dem24k \
		$(use_enable gps realtime-gps-tracking) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README doc/GEOCODED-PHOTOS doc/GETTING-STARTED doc/GPSMAPPER
}
