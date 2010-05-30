# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.7.10.ebuild,v 1.5 2010/05/30 18:29:34 armin76 Exp $

EAPI=3
inherit toolchain-funcs

MY_P=${P}-nolib

DESCRIPTION="Portable Network Graphics (PNG) optimizing utility"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${MY_P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2.40
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S=${WORKDIR}/${MY_P}

src_prepare() {
	cp -f "${FILESDIR}"/Makefile . || die
	tc-export CC
}

src_install() {
	dobin ${PN} || die
	dohtml ChangeLog.html || die
}
