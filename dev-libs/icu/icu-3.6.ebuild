# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-3.6.ebuild,v 1.1 2006/11/06 10:01:43 sebastian Exp $

KEYWORDS="~amd64 ~hppa ~mips ppc ~ppc-macos ~ppc64 sparc x86"

MY_PV=${PV/./_}

DESCRIPTION="IBM Internationalization Components for Unicode."
SRC_URI="ftp://ftp.software.ibm.com/software/globalization/icu/${PV}/icu4c-${MY_PV}-src.tgz"
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
