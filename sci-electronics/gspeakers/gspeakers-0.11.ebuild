# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gspeakers/gspeakers-0.11.ebuild,v 1.10 2012/05/04 07:10:19 jdhore Exp $

EAPI="1"

inherit eutils gnome2 autotools

DESCRIPTION="GTK based loudspeaker enclosure and crossovernetwork designer"
HOMEPAGE="http://gspeakers.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE=""

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-libs/libxml2:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	|| ( >=sci-electronics/gnucap-0.34
		sci-electronics/ngspice
		sci-electronics/spice )"

DOCS="README* INSTALL Changelog AUTHORS NEWS ABOUT"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}
