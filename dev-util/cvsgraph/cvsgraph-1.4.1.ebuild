# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsgraph/cvsgraph-1.4.1.ebuild,v 1.1 2004/09/10 08:55:07 tigger Exp $

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
	dodoc ${S}/mkimage.php3
	dodoc ${S}/cvsgraphwrapper.php3
}
