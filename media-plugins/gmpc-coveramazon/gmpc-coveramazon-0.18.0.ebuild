# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-coveramazon/gmpc-coveramazon-0.18.0.ebuild,v 1.9 2011/02/16 19:19:47 angelos Exp $

EAPI=2

DESCRIPTION="This plugin fetches cover art and album information from Amazon"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Coveramazon"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	!>=media-sound/gmpc-0.19
	dev-libs/libxml2
	|| ( x11-libs/gdk-pixbuf:2[jpeg] x11-libs/gtk+:2[jpeg] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
