# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.09-r1.ebuild,v 1.4 2011/03/30 11:08:48 angelos Exp $

WANT_AUTOMAKE=1.7
WANT_AUTOCONF=2.5

EAPI=1
inherit autotools

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/gpsdrive.tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="garmin mysql"

RDEPEND=">=x11-libs/gtk+-2.8.12:2
	>=dev-libs/libpcre-4.2
	mysql? ( dev-db/mysql )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

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
	    --enable-shared --enable-static $(use_enable garmin) \
		|| die "econf failed"

	emake || die "emake failed"
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
