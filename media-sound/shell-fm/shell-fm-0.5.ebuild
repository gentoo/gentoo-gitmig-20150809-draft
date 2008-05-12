# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.5.ebuild,v 1.2 2008/05/12 15:29:40 drac Exp $

inherit toolchain-funcs

DESCRIPTION="A lightweight console based player for Last.FM radio streams."
HOMEPAGE="http://nex.scrapping.cc/code/shell-fm"
SRC_URI="http://nex.scrapping.cc/code/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libmad
	media-libs/libao"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:gcc:$(tc-getCC):" -e "s:-Os:${CFLAGS}:" \
		source/Makefile || die "sed failed."
}

src_compile() {
	tc-export CC
	emake -C source || die "emake failed."
}

src_install() {
	dobin source/${PN} || die "dobin failed."
	doman manual/${PN}.1
	exeinto /usr/share/${PN}/scripts
	doexe scripts/{*.sh,zcontrol} || die "doexe failed."
}
