# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sexypsf/sexypsf-0.4.6.ebuild,v 1.1 2004/10/07 23:50:44 eradicator Exp $

IUSE="xmms"

inherit eutils

MY_P="${PN}${PV//./}"
S="${WORKDIR}/${PN}"

DESCRIPTION="sexyPSF is an open-source PSF (Playstation music) file player"
HOMEPAGE="http://xod.fobby.net/${PN}/"
SRC_URI="http://xod.fobby.net/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

#-amd64: 0.4.6: Segfault on playback using sexypsf.
#-sparc: 0.4.5: Couldn't load minispf
KEYWORDS="~x86 ~ppc -amd64 -sparc"

DEPEND="sys-libs/zlib
	xmms? ( media-sound/xmms )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-xmms.patch
}

src_compile() {
	cd ${S}/Linux

	# ppc and sparc are big-endian while all other keywords are
	# little-endian (as far as I know)
	use ppc64 || use ppc || use sparc && CPU="MSBFIRST" || CPU="LSBFIRST"

	emake CPU="${CPU}" || die

	if use xmms; then
		cd ${S}/xmms
		emake CPU="${CPU}" || die
	fi
}

src_install() {
	cd ${S}/Linux
	dobin sexypsf

	if use xmms; then
		cd ${S}/xmms
		exeinto `xmms-config --input-plugin-dir`
		doexe libsexypsf.so
	fi

	dodoc ${S}/Docs/*
}

pkg_postinst() {
	ewarn "The xmms plugin seems to be unstable.  It does not play minipsf files,"
	ewarn "but the command line works fine with them."
}
