# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitler-yuv/subtitler-yuv-0.6.5.ebuild,v 1.3 2007/07/22 08:40:37 dberkholz Exp $

inherit toolchain-funcs

DESCRIPTION="for mjpegtools for adding subtitles, pictures, and effects embedded in the picture"
HOMEPAGE="http://home.zonnet.nl/panteltje/subtitles/"
#SRC_URI="http://home.zonnet.nl/panteltje/subtitles/${P}.tgz"
# using ibibio mirror as the webpage itself seems to be offline at the moment
SRC_URI="http://www.ibiblio.org/pub/linux/apps/video/subtitler-yuv-0.6.5.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="x11-libs/libXaw"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/usr/X11R6:/usr:' \
		-e 's:gcc:$(CC):g' \
		Makefile || die "sed failed in Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin subtitler-yuv
	dodoc CHANGES HOWTO_USE_THIS README README.COLOR.PROCESSOR README.PPML
	insinto /usr/share/${PN}
	doins demo-yuv.ppml rose.ppm sun.ppm mp-arial-iso-8859-1.zip
}
