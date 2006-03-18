# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.0-r3.ebuild,v 1.2 2006/03/18 12:58:46 zzam Exp $

inherit eutils

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Disable compilation of sample programs
	# and use DESTDIR when installing
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/errno.patch"
	epatch "${FILESDIR}/${P}-gentoo-file-collisions.patch"
	sed -i.orig Makefile -e 's-/include-/include/libdvb-g'
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
