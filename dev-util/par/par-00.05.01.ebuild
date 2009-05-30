# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/par/par-00.05.01.ebuild,v 1.7 2009/05/30 02:04:49 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="par manipulates PalmOS database files"
HOMEPAGE="http://www.djw.org/product/palm/par/"
SRC_URI="http://www.djw.org/product/palm/par/prc.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="!app-text/par
	!app-arch/par"
RDEPEND="${DEPEND}"

S="${WORKDIR}/prc"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die 'Failed to compile!'
	emake par.man || die 'Failed to make man page!'
}

src_install () {
	dobin par || die 'dobin failed'
	dolib *.a || die 'dolib *.a failed'

	newman par.man par.1 || die 'newman failed'
}
