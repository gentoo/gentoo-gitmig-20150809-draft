# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.0-r1.ebuild,v 1.4 2004/03/26 13:48:03 dholm Exp $

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ia64 ~amd64 ~ppc"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.0.1"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Disable compilation of sample programs
	# and use DESTDIR when installing
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" PREFIX=/usr install || die

	insinto "/usr/share/doc/${PF}/sample_progs"
	doins sample_progs/*
	insinto "/usr/share/doc/${PF}/samplerc"
	doins samplerc/*

	dodoc README
}
