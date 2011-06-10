# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tomsfastmath/tomsfastmath-0.12.ebuild,v 1.3 2011/06/10 01:25:49 radhermit Exp $

inherit eutils

DESCRIPTION="portable fixed precision math library geared towards doing one thing very fast"
HOMEPAGE="http://libtom.org/"
SRC_URI="http://libtom.org/files/tfm-${PV}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

src_compile() {
	emake IGNORE_SPEED=1 || die
}

src_install() {
	dolib.a libtfm.a || die "dolib.a"
	insinto /usr/include
	doins src/headers/tfm.h || die "doins failed"
	dodoc changes.txt doc/*.pdf
	docinto demo ; dodoc demo/*.c
}
