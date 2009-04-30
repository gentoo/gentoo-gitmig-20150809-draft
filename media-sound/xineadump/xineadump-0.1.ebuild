# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xineadump/xineadump-0.1.ebuild,v 1.4 2009/04/30 19:31:14 ranger Exp $

inherit eutils

DESCRIPTION="Utility for Xine decoding support in transKode"
HOMEPAGE="http://sourceforge.net/projects/transkode"
SRC_URI="mirror://sourceforge/transkode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/xine-lib"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
}
