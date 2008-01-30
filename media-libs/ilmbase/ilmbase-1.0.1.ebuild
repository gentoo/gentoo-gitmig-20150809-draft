# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ilmbase/ilmbase-1.0.1.ebuild,v 1.6 2008/01/30 14:21:46 armin76 Exp $

inherit libtool eutils

DESCRIPTION="OpenEXR ILM Base libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.nongnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="!<media-libs/openexr-1.5.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.0.0-asneeded.patch"

	# Sane versioning on FreeBSD - please don't remove elibtoolize
	elibtoolize
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
