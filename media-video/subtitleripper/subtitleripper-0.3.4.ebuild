# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleripper/subtitleripper-0.3.4.ebuild,v 1.5 2005/06/27 07:45:11 corsair Exp $

DESCRIPTION="DVD Subtitle Ripper for Linux"
HOMEPAGE="http://subtitleripper.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
SRC_URI="mirror://sourceforge/subtitleripper/subtitleripper-0.3-4.tgz"
SLOT="0"
IUSE=""

DEPEND="media-libs/netpbm
		media-libs/libpng
		sys-libs/zlib"

S="${WORKDIR}/subtitleripper"

src_compile() {
	sed -i -e "s:ppm:netpbm:g" Makefile

	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe pgm2txt srttool subtitle2pgm subtitle2vobsub vobsub2pgm

	dodoc ChangeLog README*
}
