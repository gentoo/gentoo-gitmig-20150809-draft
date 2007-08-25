# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-3.4.1.ebuild,v 1.15 2007/08/25 22:38:25 vapier Exp $

KEYWORDS="~amd64 arm ~hppa ~mips ppc ~ppc64 s390 sh sparc x86"

DESCRIPTION="IBM Internationalization Components for Unicode."
HOMEPAGE="http://ibm.com/software/globalization/icu/"
SRC_URI="ftp://ftp.software.ibm.com/software/globalization/icu/${PV}/${P}.tgz"

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
