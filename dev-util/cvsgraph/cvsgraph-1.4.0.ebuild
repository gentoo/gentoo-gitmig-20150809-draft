# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsgraph/cvsgraph-1.4.0.ebuild,v 1.6 2004/07/14 23:02:14 agriffis Exp $

DESCRIPTION="CVS/RCS repository grapher"
HOMEPAGE="http://www.akhphd.au.dk/~bertho/cvsgraph"
SRC_URI="http://www.akhphd.au.dk/~bertho/cvsgraph/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="gif jpeg nls png truetype zlib"

DEPEND="media-libs/gd
	zlib? ( sys-libs/zlib )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )"

src_compile() {
	local myopts

	myopts="`use_enable nls` `use_enable gif` `use_enable png` `use_enable jpeg` `use_enable truetype`"

	econf ${myopts} || die "econf failed"
	emake || die
}

src_install () {
	dobin ${S}/cvsgraph
	insinto /etc
	doins ${S}/cvsgraph.conf
	doman ${S}/cvsgraph.1 ${S}/cvsgraph.conf.5
}
