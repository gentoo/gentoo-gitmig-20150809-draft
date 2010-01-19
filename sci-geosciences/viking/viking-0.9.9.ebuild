# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/viking/viking-0.9.9.ebuild,v 1.1 2010/01/19 11:10:01 hanno Exp $

DESCRIPTION="Viking is a program to manage GPS data."
HOMEPAGE="http://viking.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="gps nls"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.2.0
	gps? ( sci-geosciences/gpsd )
	nls? ( sys-devel/gettext )
	net-misc/curl
	sci-geosciences/gpsbabel"
DEPEND=">=x11-libs/gtk+-2.2.0
	gps? ( sci-geosciences/gpsd )
	nls? ( sys-devel/gettext )
	dev-util/intltool
	dev-util/pkgconfig"

src_compile() {
	econf --enable-openstreetmap \
		--enable-expedia \
		--enable-terraserver \
		--enable-google \
		$(use_enable gps realtime-gps-tracking) \
		$(use_enable nls) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README doc/GEOCODED-PHOTOS doc/GETTING-STARTED doc/GPSMAPPER \
		|| die "Unable to install docs"
}
