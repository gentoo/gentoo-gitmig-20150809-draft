# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xfitsview/xfitsview-2.2-r1.ebuild,v 1.1 2010/09/15 13:01:59 xarthisius Exp $

EAPI=2
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

DEPEND="x11-libs/openmotif"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	find "${S}" -name "*old.c" -delete || die
	epatch "${FILESDIR}"/${P}-build_system.patch
}

src_install() {
	dobin XFITSview || die
	dodoc README changes notes.text || die
}
