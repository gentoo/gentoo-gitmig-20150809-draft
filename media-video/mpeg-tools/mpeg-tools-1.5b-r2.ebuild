# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg-tools/mpeg-tools-1.5b-r2.ebuild,v 1.6 2007/01/05 20:39:33 flameeyes Exp $

inherit eutils

MY_PN=mpeg_encode
DESCRIPTION="Tools for MPEG video"
HOMEPAGE="http://bmrc.berkeley.edu/research/mpeg/mpeg_encode.html"
SRC_URI="ftp://mm-ftp.cs.berkeley.edu/pub/multimedia/mpeg/encode/${MY_PN}-${PV}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( x11-libs/libX11 virtual/x11 )
	media-libs/jpeg"

S=${WORKDIR}/${MY_PN}

src_unpack () {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-64bit_fixes.patch
	epatch "${FILESDIR}"/${P}-tempfile-convert.patch
	cd "${S}"
	rm -r jpeg
	epatch "${FILESDIR}"/${P}-system-jpeg.patch
	epatch "${FILESDIR}"/${P}-tempfile-mpeg-encode.patch
	epatch "${FILESDIR}"/${P}-tempfile-tests.patch
}

src_compile() {
	emake || die "make"
	emake -C convert || die "make convert"
	emake -C convert/mtv || die "make mtv"
}

src_install () {
	dobin mpeg_encode || die "dobin mpeg_encode"
	doman docs/*.1
	dodoc BUGS CHANGES README TODO VERSION
	dodoc docs/EXTENSIONS docs/INPUT.FORMAT docs/*.param docs/param-summary
	docinto examples
	dodoc examples/*

	cd ../convert
	dobin eyuvtojpeg jmovie2jpeg mpeg_demux mtv/movieToVid || die "dobin convert utils"
	newdoc README README.convert
	newdoc mtv/README README.mtv
}

pkg_postinst() {
	if [[ -z $(best_version media-libs/netpbm) ]] ; then
		elog "If you are looking for eyuvtoppm or ppmtoeyuv, please"
		elog "emerge the netpbm package.  It has updated versions."
	fi
}
