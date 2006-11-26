# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-3.6.ebuild,v 1.4 2006/11/26 21:40:12 dev-zero Exp $

KEYWORDS="~amd64 ~arm ~hppa ~mips ppc ~ppc-macos ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"

DESCRIPTION="IBM Internationalization Components for Unicode."
HOMEPAGE="http://ibm.com/software/globalization/icu/"
SRC_URI="ftp://ftp.software.ibm.com/software/globalization/icu/${PV}/icu4c-${PV/./_}-src.tgz"

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
