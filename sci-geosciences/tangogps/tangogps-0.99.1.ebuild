# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tangogps/tangogps-0.99.1.ebuild,v 1.1 2009/11/25 08:51:16 bangert Exp $

EAPI="2"

inherit eutils

DESCRIPTION="tangogps is an easy to use, fast and lightweight mapping
application for use with or without GPS."
HOMEPAGE="http://www.tangogps.org/"
SRC_URI="http://www.tangogps.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gps"

RDEPEND="x11-libs/gtk+
		sys-apps/dbus
		gnome-base/gconf
		net-misc/curl
		media-libs/libexif
		dev-libs/libxml2
		gps? ( >=sci-geosciences/gpsd-2.34 )"
DEPEND="sys-devel/gettext
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.5-Makefile.in-honour-docdir.patch"
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${P} \
		|| die "Configure failed!"

}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
