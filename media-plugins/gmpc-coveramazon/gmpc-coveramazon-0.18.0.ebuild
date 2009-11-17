# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-coveramazon/gmpc-coveramazon-0.18.0.ebuild,v 1.6 2009/11/17 16:49:52 angelos Exp $

EAPI=2

DESCRIPTION="This plugin fetches cover art and album information from Amazon"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Coveramazon"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	!>=media-soung/gmpc-0.19
	dev-libs/libxml2
	x11-libs/gtk+:2[jpeg]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
