# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2vidcodec/mpeg2vidcodec-12-r1.ebuild,v 1.16 2004/01/30 22:43:05 mr_bones_ Exp $

MY_P="${PN}_v${PV}"
S="${WORKDIR}/mpeg2"
DESCRIPTION="MPEG Library"
HOMEPAGE="http://www.mpeg.org"
SRC_URI="ftp://ftp.mpeg.org/pub/mpeg/mssg/${MY_P}.tar.gz"

KEYWORDS="x86 ppc alpha sparc amd64 hppa"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:-O2:${CFLAGS}:" "${S}/Makefile" \
			|| die "sed Makefile failed"

}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin src/mpeg2dec/mpeg2decode src/mpeg2enc/mpeg2encode \
		|| die "dobin failed"
	dodoc README doc/* || die "dodoc failed"
}
