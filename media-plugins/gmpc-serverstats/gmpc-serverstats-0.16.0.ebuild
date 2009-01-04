# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-serverstats/gmpc-serverstats-0.16.0.ebuild,v 1.5 2009/01/04 00:09:14 angelos Exp $

inherit autotools multilib

DESCRIPTION="This plugin shows more detailed information about mpd's database"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Server_statistics"
SRC_URI="http://download.sarine.nl/Programs/gmpc/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "/^libdir/s:/lib/:/$(get_libdir)/:" src/Makefile.am
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
}
