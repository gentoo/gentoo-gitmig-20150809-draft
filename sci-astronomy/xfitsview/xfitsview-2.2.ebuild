# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xfitsview/xfitsview-2.2.ebuild,v 1.3 2009/08/17 17:09:00 bicatali Exp $

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

S="${WORKDIR}/${MY_PN}"

src_compile() {
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
