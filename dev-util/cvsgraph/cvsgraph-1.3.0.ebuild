# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsgraph/cvsgraph-1.3.0.ebuild,v 1.2 2003/09/06 08:39:20 msterret Exp $

HOMEPAGE="http://www.akhphd.au.dk/~bertho/cvsgraph"
KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="CVS/RCS repository grapher"

SRC_URI="http://www.akhphd.au.dk/~bertho/cvsgraph/release/${P}.tar.gz"
S=${WORKDIR}/${P}

IUSE="gd png gif jpeg zlib truetype nls"

DEPEND="media-libs/libgd
	zlib? ( sys-libs/zlib )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )"

src_compile() {
	local myopts

	myopts="`use_enable nls` `use_enable gif` `use_enable png` `use_enable jpeg` `use_enable truetype`"

	econf ${myopts}
	emake || die
}

src_install () {
        dobin ${S}/cvsgraph
	insinto /etc
        doins ${S}/cvsgraph.conf
        doman ${S}/cvsgraph.1 ${S}/cvsgraph.conf.5
}
