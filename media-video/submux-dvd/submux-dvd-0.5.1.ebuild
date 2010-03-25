# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/submux-dvd/submux-dvd-0.5.1.ebuild,v 1.2 2010/03/25 21:22:40 lordvan Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A subtitle multiplexer, muxes subtitles into .vob"
HOMEPAGE="http://ip51cf87c4.direct-adsl.nl/panteltje/dvd/"
SRC_URI="http://ip51cf87c4.direct-adsl.nl/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	# just 2 files not worth a makefile patch
	dobin submux-dvd vob2sub || die
	dodoc CHANGES FORMAT README ${P}.lsm ${PN}.man || die
	dohtml spu.html || die
}
