# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg-tools/mpeg-tools-1.5b.ebuild,v 1.13 2003/04/12 10:30:59 seemant Exp $

MY_PN=mpeg_encode
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Tools for MPEG video"
SRC_URI="ftp://mm-ftp.cs.berkeley.edu/pub/multimedia/mpeg/encode/${MY_PN}-${PV}-src.tar.gz"
HOMEPAGE="http://bmrc.bercley.edu/research/mpeg/mpeg_encode.html"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/${PV}/libpnmrw.c .
	cp ${FILESDIR}/${PV}/libpnmrw.h headers/
	epatch ${FILESDIR}/${PV}/${P}-gentoo.patch
}

src_compile() {

	cd ${S}
	make || die
	cd ../convert
	make || die
	cd mtv
	make || die
}

src_install () {

	cd ${S}
	into /usr
	dobin mpeg_encode
	doman docs/*.1
	dodoc BUGS CHANGES COPYRIGHT README TODO VERSION
	dodoc docs/EXTENSIONS docs/INPUT.FORMAT docs/*.param docs/param-summary
	docinto examples
	dodoc examples/*
	cd ../convert
	dobin eyuvtojpeg eyuvtoppm jmovie2jpeg mpeg_demux ppmtoeyuv mtv/movieToVid

}
