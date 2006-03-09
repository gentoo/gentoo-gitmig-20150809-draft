# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.5.1-r2.ebuild,v 1.4 2006/03/09 23:56:39 agriffis Exp $

inherit eutils

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~ppc x86"
IUSE="doc"

RDEPEND="media-tv/linuxtv-dvb-headers"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Disable compilation of sample programs
	# and use DESTDIR when installing
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-gentoo-file-collisions.patch

	sed -i -e '/^CFLAGS=/d' config.mk || die
	sed -i.orig Makefile -e 's-/include-/include/libdvb-'
}

src_install() {
	#einstall DESTDIR="${D}" || die "Install problem"
	make DESTDIR="${D}" PREFIX=/usr install || die

	use doc && insinto "/usr/share/doc/${PF}/sample_progs" && \
	doins sample_progs/* && \
	insinto "/usr/share/doc/${PF}/samplerc" && \
	doins samplerc/*

	einfo "The script called 'dia' has been installed as dia-dvb"
	einfo "so that it doesn't overwrite the binary of app-office/dia."

	dodoc README
}
