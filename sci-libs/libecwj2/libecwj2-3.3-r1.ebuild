# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libecwj2/libecwj2-3.3-r1.ebuild,v 1.5 2010/07/17 13:46:52 xarthisius Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Library for both the ECW and the ISO JPEG 2000 image file formats"
SRC_URI="mirror://gentoo/${P}-2006-09-06.zip"
HOMEPAGE="http://www.ermapper.com/ProductView.aspx?t=28"

LICENSE="ECWPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

RDEPEND="=media-libs/lcms-1*"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nolcms.patch
	rm -rf Source/C/libjpeg Source/C/NCSEcw/lcms
	# bug 328075
	sed -i -e "s:includeHEADERS_INSTALL:INSTALL_HEADER:" \
		Source/NCSBuildGnu/Makefile.am || die
	eautoreconf
}

src_install() {
	dodir /usr/include
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /usr/share/doc/${PF}/
	if use doc; then
		dodoc SDK.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
