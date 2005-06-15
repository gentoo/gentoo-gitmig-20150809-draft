# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsgraph/cvsgraph-1.5.2.ebuild,v 1.1 2005/06/15 11:56:09 ka0ttic Exp $

DESCRIPTION="CVS/RCS repository grapher"
HOMEPAGE="http://www.akhphd.au.dk/~bertho/cvsgraph"
SRC_URI="http://www.akhphd.au.dk/~bertho/cvsgraph/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc -alpha -amd64 -ia64"
IUSE="gif jpeg nls png truetype zlib"

DEPEND="media-libs/gd
	zlib? ( sys-libs/zlib )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable gif) \
		$(use_enable png) \
		$(use_enable jpeg) \
		$(use_enable truetype) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	dobin cvsgraph
	insinto /etc
	doins cvsgraph.conf
	doman cvsgraph.1 cvsgraph.conf.5
	dodoc ChangeLog README contrib/*.php3
}
