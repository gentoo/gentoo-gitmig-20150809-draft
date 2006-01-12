# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/swftools/swftools-0.7.1.20051207.ebuild,v 1.1 2006/01/12 18:19:04 vanquirius Exp $

# NOTE: development version ebuild, be careful

inherit eutils

DESCRIPTION="SWF Tools is a collection of SWF manipulation and generation utilities"
HOMEPAGE="http://www.swftools.org/"
SRC_URI="http://www.swftools.org/${PN}-dev.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-libs/t1lib-1.3.1
		media-libs/freetype
		media-libs/jpeg"
RDEPEND=""

S="${WORKDIR}/${PN}-2005-12-07-1809"

src_install() {
	einstall || die "Install died."
	dodoc AUTHORS ChangeLog FAQ TODO
}
