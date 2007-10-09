# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ilmbase/ilmbase-1.0.0.ebuild,v 1.6 2007/10/09 16:52:57 corsair Exp $

inherit eutils

DESCRIPTION="OpenEXR ILM Base libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.nongnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="!<media-libs/openexr-1.5.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
