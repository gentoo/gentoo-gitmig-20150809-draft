# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jp2a/jp2a-1.0.6-r1.ebuild,v 1.8 2009/10/31 14:21:19 ranger Exp $

DESCRIPTION="JPEG image to ASCII art converter"
HOMEPAGE="http://csl.sublevel3.org/jp2a/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 ~sparc x86"
IUSE="curl"
DEPEND="media-libs/jpeg
	curl? ( net-misc/curl )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable curl) || die
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dohtml man/jp2a.html
}
