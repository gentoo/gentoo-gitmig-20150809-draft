# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.09-r1.ebuild,v 1.2 2007/08/23 06:23:47 nerdboy Exp $

inherit autotools

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/gpsdrive.tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
# submit bug for ppc64

IUSE="garmin mysql static"

DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.8.12
	>=dev-libs/libpcre-4.2"

RDEPEND="${DEPEND}
	mysql?	( dev-db/mysql )"

WANT_AUTOMAKE=1.7
WANT_AUTOCONF=2.5

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-configure.patch
	sed -i -e "s:^EXTRA_DIST.*$::" Makefile.am \
		-e "s:^pkgdata_DATA.*$::" Makefile.am

	eautoreconf
}

src_compile() {
	econf \
	    --enable-shared $(use_enable garmin) $(use_enable static) \
		|| die "econf failed"

	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS create.sql CREDITS Changelog FAQ* GPS-receivers NMEA.txt \
		README* TODO wp2sql
}

pkg_postinst() {
	if use mysql; then
		echo -e "\n"
		elog "Be sure to see the README.SQL file in /usr/share/doc/${PF}"
		elog "for information on using MySQL with gpsdrive.\n"
	fi
}
