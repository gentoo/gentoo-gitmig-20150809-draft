# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/as11/as11-1.0.ebuild,v 1.9 2010/10/02 14:52:28 tomjbe Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Motorola's AS11 Assembler for the 68HC11"
HOMEPAGE="http://www.ai.mit.edu/people/rsargent/as11.html"
SRC_URI="http://www.ai.mit.edu/people/rsargent/source/${PN}_src.tar.gz"
LICENSE="freedist"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e "s/ -o/\$(LDFLAGS) -o/g" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "Compile failed"
}

src_install() {
	dobin as11
	dodoc as11.doc CHANGELOG README
}
