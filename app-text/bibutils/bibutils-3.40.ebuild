# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibutils/bibutils-3.40.ebuild,v 1.2 2008/02/12 22:53:28 mr_bones_ Exp $

inherit toolchain-funcs

MY_P="${P/-/_}"
DESCRIPTION="Interconverts between various bibliography formats using a common XML intermediate"
HOMEPAGE="http://www.scripps.edu/~cdputnam/software/bibutils"
SRC_URI="http://www.scripps.edu/~cdputnam/software/bibutils/${MY_P}_src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	# The custom configure script sucks, so we'll just do its
	# job ourselves
	rm -f Makefile || die "Failed to purge old Makefile"
	sed \
		-e "s:REPLACE_CC:CC=\"$(tc-getCC) ${CFLAGS}\":g" \
		-e "s:REPLACE_RANLIB:RANLIB=\"$(tc-getRANLIB)\":g" \
		-e "s:REPLACE_INSTALLDIR:\"${D}/usr/bin\":g" \
		-e "s:REPLACE_POSTFIX::g" \
		Makefile_start \
		> Makefile \
		|| die "Failed to set upt Makefile"

	emake || die "emake failed"
}
src_install() {
	dodir /usr/bin
	emake install || die "emake install failed"

	dodoc ChangeLog
}
