# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.5.1-r3.ebuild,v 1.2 2006/07/24 20:10:01 zzam Exp $

inherit eutils autotools

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="doc"

DEPEND="media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-autotools.patch"
	epatch "${FILESDIR}/${P}-rename-analyze.patch"

	eautoreconf
}

src_install() {
	#einstall DESTDIR="${D}" || die "Install problem"
	insinto /usr/$(get_libdir)
	make DESTDIR="${D}" PREFIX=/usr LIBDIR=$(get_libdir) install || die "Problem at make install"

	cd ${D}/usr/bin
	mv dia dia_dvb

	cd ${S}
	if use doc; then
		insinto "/usr/share/doc/${PF}/sample_progs"
		doins sample_progs/*
		insinto "/usr/share/doc/${PF}/samplerc"
		doins samplerc/*
	fi

	einfo "The script called 'dia' has been installed as dia_dvb"
	einfo "so that it doesn't overwrite the binary of app-office/dia."
	einfo "analyze has been renamed to analyze_mpg."

	dodoc README
}
