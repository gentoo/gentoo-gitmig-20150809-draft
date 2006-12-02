# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/par/par-00.05.01.ebuild,v 1.5 2006/12/02 11:13:06 masterdriverz Exp $

DESCRIPTION="par manipulates PalmOS database files"
HOMEPAGE="http://www.djw.org/product/palm/par/"
SRC_URI="http://www.djw.org/product/palm/par/prc.tgz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="!app-text/par
	!app-arch/par"

S="${WORKDIR}/prc"

src_compile() {
	emake || die 'Failed to compile!'
	emake par.man || die 'Failed to make man page!'
}

src_install () {
	dobin par || die 'dobin failed'
	dolib *.a *.so

	newman par.man par.1
}
