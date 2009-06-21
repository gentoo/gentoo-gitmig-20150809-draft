# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/plink/plink-1.06.ebuild,v 1.1 2009/06/21 14:58:13 weaver Exp $

EAPI="2"

DESCRIPTION="Whole genome association analysis toolset"
HOMEPAGE="http://pngu.mgh.harvard.edu/~purcell/plink/"
SRC_URI="http://pngu.mgh.harvard.edu/~purcell/plink/dist/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
IUSE="-webcheck"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${P}-src"

# Package collides with net-misc/putty. Renamed to p-link following discussion with Debian.
# Package contains bytecode-only jar gPLINK.jar. Ignored, notified upstream.

src_prepare() {
	sed -i -e '/CXXFLAGS =/ s/^/#/' -e 's/-static//' "${S}/Makefile" || die
	use webcheck || sed -i '/WITH_WEBCHECK =/ s/^/#/' "${S}/Makefile" || die
}

src_install() {
	newbin plink p-link || die
	dodoc README.txt
}
