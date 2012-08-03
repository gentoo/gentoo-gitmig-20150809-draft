# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qfits/qfits-6.2.0.ebuild,v 1.4 2012/08/03 19:59:45 bicatali Exp $

EAPI=4

inherit eutils

DESCRIPTION="ESO stand-alone C library offering easy access to FITS files"
HOMEPAGE="http://www.eso.org/projects/aot/qfits/"
SRC_URI="ftp://ftp.hq.eso.org/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
DEPEND=""
RDEPEND=""

src_prepare() {
	# test failed due to a switch between strcpy and strcat.
	epatch "${FILESDIR}"/${P}-ttest.patch
	# for _FORTIFY_SOURCE=2 see bug #260674
	epatch "${FILESDIR}"/${P}-open.patch
}

src_install() {
	default
	use doc && dohtml html/*
}
