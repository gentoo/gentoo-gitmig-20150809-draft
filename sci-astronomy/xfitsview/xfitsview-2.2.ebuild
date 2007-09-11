# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xfitsview/xfitsview-2.2.ebuild,v 1.1 2007/09/11 11:36:29 bicatali Exp $

inherit eutils

MY_PN=XFITSview
MY_P=${MY_PN}${PV}

DESCRIPTION="Viewer for astronomical images in FITS format"
HOMEPAGE="http://www.nrao.edu/software/fitsview/"
SRC_URI="ftp://ftp.cv.nrao.edu/fits/os-support/unix/xfitsview/${PN}${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"
DEPEND="virtual/motif"

S=${WORKDIR}/${MY_PN}

src_compile() {
	econf || die "econf failed"
	# trick to make parallel building work
	for d in fitssubs src; do
	   pushd ${d}
	   emake || die "emake ${d} failed"
	   popd
	done
	emake -j1 || die "emake failed"
}

src_install() {
	dobin XFITSview || die "dobin failed"
	dodoc README changes notes.text || die "dodoc failed"
}
