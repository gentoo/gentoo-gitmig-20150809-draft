# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/submux-dvd/submux-dvd-0.5.1.ebuild,v 1.3 2012/01/29 20:20:38 lordvan Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A subtitle multiplexer, muxes subtitles into .vob"
# 404 on those original pages
#HOMEPAGE="http://ip51cf87c4.direct-adsl.nl/panteltje/dvd/"
#SRC_URI="http://ip51cf87c4.direct-adsl.nl/panteltje/dvd/${P}.tgz"
# temporarily linking lsm + sunsite
HOMEPAGE="http://www.boutell.com/lsm/lsmbyid.cgi/002197"
SRC_URI="ftp://sunsite.unc.edu/pub/linux/apps/video/${P}.tgz"

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
