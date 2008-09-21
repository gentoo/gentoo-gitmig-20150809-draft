# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fblogo/fblogo-0.5.2.ebuild,v 1.7 2008/09/21 06:53:32 solar Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="Creates images to substitute Linux boot logo"
HOMEPAGE="http://freakzone.net/gordon/#fblogo"
SRC_URI="http://freakzone.net/gordon/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~arm ~ppc ~sparc x86"

DEPEND=">=sys-apps/sed-4
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fblogo-0.5.2-cross.patch
}

src_compile() {
	tc-export CC
	emake CC="${CC}" || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README CHANGES
}
