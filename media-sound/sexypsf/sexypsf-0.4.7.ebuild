# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sexypsf/sexypsf-0.4.7.ebuild,v 1.6 2006/08/07 11:56:54 lu_zero Exp $

inherit eutils flag-o-matic

DESCRIPTION="sexyPSF is an open-source PSF1 (Playstation music) file player"
HOMEPAGE="http://projects.raphnet.net/#sexypsf"
SRC_URI="http://projects.raphnet.net/sexypsf/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

#-sparc: 0.4.5: Couldn't load minispf
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="xmms"

DEPEND="sys-libs/zlib
	xmms? ( media-sound/xmms )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-misc.patch
}

src_compile() {
	cd "${S}"/Linux

	# ppc and sparc are big-endian while all other keywords are
	# little-endian (as far as I know)
	use ppc64 || use ppc || use sparc && append-flags -DMSBFIRST
	emake || die "emake failed"

	if use xmms; then
		cd "${S}"
		# do make clean to force rebuild with -fPIC
		make clean || die "make clean failed"
		# don't generate separate xmms and bmp plugins; they're compatible
		emake sexypsf || die "building plugin failed"
	fi
}

src_install() {
	dobin Linux/sexypsf

	if use xmms; then
		exeinto "$(xmms-config --input-plugin-dir)"
		doexe libsexypsf.so
	fi

	dodoc Docs/*
}
