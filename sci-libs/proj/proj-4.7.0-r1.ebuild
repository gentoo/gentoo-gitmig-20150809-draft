# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/proj/proj-4.7.0-r1.ebuild,v 1.1 2012/01/26 18:12:58 bicatali Exp $

EAPI=4

DESCRIPTION="Proj.4 cartographic projection software with updated NAD27 grids"
HOMEPAGE="http://trac.osgeo.org/proj/"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz
	http://download.osgeo.org/proj/${PN}-datumgrid-1.5.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="static-libs"

RDEPEND=""
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd "${S}"/nad || die
	mv README README.NAD || die
	unpack ${PN}-datumgrid-1.5.zip || die
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-robinson.patch
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	cd nad
	dodoc README.{NAD,NADUS}
	insinto /usr/share/proj
	insopts -m 755
	doins test27 test83
	insopts -m 644
	doins pj_out27.dist pj_out83.dist
}
