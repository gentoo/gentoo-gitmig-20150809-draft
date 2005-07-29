# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/par/par-00.05.01.ebuild,v 1.4 2005/07/29 02:06:49 swegener Exp $

DESCRIPTION="par manipulates PalmOS database files"
HOMEPAGE="http://www.djw.org/product/palm/par/"
SRC_URI="http://www.djw.org/product/palm/par/prc.tgz"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~ppc"
IUSE=""
S="${WORKDIR}/prc"

src_compile() {
	emake || die 'Failed to compile!'
	emake par.man || die 'Failed to make man page!'
}

src_install () {
	dobin par
	dolib *.a *.so

	newman par.man par.1
}
