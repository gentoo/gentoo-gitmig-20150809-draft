# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibutils/bibutils-3.27.ebuild,v 1.2 2006/10/27 16:13:26 chriswhite Exp $

inherit toolchain-funcs

MY_P="${P/-/_}"
DESCRIPTION="Interconverts between various bibliography formats using a common XML intermediate"
HOMEPAGE="http://www.scripps.edu/~cdputnam/software/bibutils/bibutils.html"
SRC_URI="http://www.scripps.edu/~cdputnam/software/bibutils/${MY_P}_src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	# The custom configure script sucks, so we'll just do its job ourselves
	sed \
		-e "s:REPLACE_CC:CC=\"$(tc-getCC) ${CFLAGS}\":g" \
		-e "s:REPLACE_RANLIB:RANLIB=\"$(tc-getRANLIB)\":g" \
		-e "s:REPLACE_INSTALLDIR:\"${D}/usr/bin\":g" \
		-e "s:REPLACE_POSTFIX::g" \
		Makefile_start \
		> Makefile

	emake || die "emake failed"
}
src_install() {
	dodir /usr/bin
	emake install || die "emake install failed"

	dodoc ChangeLog
}
