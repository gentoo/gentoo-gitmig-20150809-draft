# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-3.4.1.ebuild,v 1.9 2006/10/01 22:20:57 dertobi123 Exp $

KEYWORDS="~amd64 ~hppa ppc ~ppc-macos ~ppc64 sparc ~x86"

DESCRIPTION="IBM Internationalization Components for Unicode."
SRC_URI="ftp://ftp.software.ibm.com/software/globalization/icu/${PV}/${P}.tgz"
HOMEPAGE="http://ibm.com/software/globalization/icu/"

SLOT="0"
LICENSE="as-is"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}/source"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dohtml ../readme.html ../license.html
}
