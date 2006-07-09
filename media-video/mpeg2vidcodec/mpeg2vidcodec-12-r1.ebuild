# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2vidcodec/mpeg2vidcodec-12-r1.ebuild,v 1.28 2006/07/09 12:08:23 the_paya Exp $

MY_P="${PN}_v${PV}"
DESCRIPTION="MPEG Library"
HOMEPAGE="http://www.mpeg.org/"
SRC_URI="ftp://ftp.mpeg.org/pub/mpeg/mssg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

S=${WORKDIR}/mpeg2

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		"${S}"/Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dobin src/mpeg2dec/mpeg2decode src/mpeg2enc/mpeg2encode \
		|| die "dobin failed"
	dodoc README doc/*
}
