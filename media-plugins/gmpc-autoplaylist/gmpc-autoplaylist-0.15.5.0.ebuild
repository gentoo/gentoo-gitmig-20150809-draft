# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-autoplaylist/gmpc-autoplaylist-0.15.5.0.ebuild,v 1.7 2009/01/04 00:02:05 angelos Exp $

DESCRIPTION="This plugin allows you to generate a playlist based on a set of rules"
HOMEPAGE="http://sarine.nl/gmpc-plugins-autoplaylist"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
