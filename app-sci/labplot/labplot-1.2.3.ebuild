# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/labplot/labplot-1.2.3.ebuild,v 1.1 2004/05/01 10:19:05 centic Exp $

inherit eutils kde
need-kde 3.1

MY_P=${PN/labp/LabP}-${PVR/_/.}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="LabPlot is a program for two- and three-dimensional graphical presentation of data sets and functions"
HOMEPAGE="http://mitarbeiter.mbi-berlin.de/gerlach/Linux/LabPlot/"
SRC_URI="${HOMEPAGE}src/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
RESTRICT="nomirror"

SLOT="0"
IUSE="doc fftw imagemagick tiff"

MAKEOPTS="${MAKEOPTS} -j1"

DEPEND=">=dev-libs/gsl-1.3
	fftw? ( >=dev-libs/fftw-2.1.5 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	>=media-gfx/pstoedit-3.33
	tiff? ( >=media-libs/tiff-3.5.5 )
	>=media-libs/jasper-1.700.5-r1"

src_install() {
	dodir /usr/share/doc/HTML/en/LabPlot/
	kde_src_install
	if use doc ; then
		insinto /usr/share/doc/${PF}/examples
		doins   ${S}/examples/*
		insinto /usr/share/doc/${PF}/examples/data
		doins   ${S}/examples/data/*
	fi
}

