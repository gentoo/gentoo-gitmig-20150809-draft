# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr_ctl/openexr_ctl-1.0.1-r1.ebuild,v 1.3 2008/12/17 07:50:00 ssuominen Exp $

inherit eutils autotools

DESCRIPTION="OpenEXR CTL libraries"
HOMEPAGE="http://sourceforge.net/projects/ampasctl"
SRC_URI="mirror://sourceforge/ampasctl/${P}.tar.gz"

LICENSE="AMPAS"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/ilmbase
	media-libs/openexr
	media-libs/ctl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-configure_gcc43.patch
	epatch "${FILESDIR}"/${P}-pkgconfig.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
