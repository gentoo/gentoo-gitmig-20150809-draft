# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tomsfastmath/tomsfastmath-0.12-r1.ebuild,v 1.1 2009/04/03 19:09:53 tommy Exp $

inherit eutils toolchain-funcs

DESCRIPTION="portable fixed precision math library geared towards doing one thing very fast"
HOMEPAGE="http://libtom.org/"
SRC_URI="http://libtom.org/files/tfm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

src_compile() {
	sed -i -e "s:gcc:$(tc-getCC):g" \
		-e "s:--mode=link gcc:--mode=link $(tc-getCC) --tag=CC $(tc-getCC):g" \
		makefile.shared
	emake -f makefile.shared IGNORE_SPEED=1 || die
}

src_install() {
	emake -f makefile.shared DESTDIR="${D}" install || die
	dodoc changes.txt doc/*.pdf || die
	docinto demo ; dodoc demo/*.c || die
}
