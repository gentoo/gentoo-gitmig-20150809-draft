# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tangogps/tangogps-0.9.6.ebuild,v 1.1 2009/02/05 19:30:48 bangert Exp $

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
		gps? ( >=sci-geosciences/gpsd-2.34 )"
DEPEND="sys-devel/gettext
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.9.5-Makefile.in-honour-docdir.patch"
}

src_compile() {
	econf \
		--docdir=/usr/share/doc/${P} \
		|| die "Configure failed!"

	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
