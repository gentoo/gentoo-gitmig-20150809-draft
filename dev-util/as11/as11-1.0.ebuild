# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/as11/as11-1.0.ebuild,v 1.1 2003/09/23 03:02:32 zul Exp $

DESCRIPTION="Motorola's AS11 Assembler for the 68HC11"
HOMEPAGE="http://www.ai.mit.edu/people/rsargent/as11.html"
SRC_URI="http://www.ai.mit.edu/people/rsargent/source/${PN}_src.tar.gz"
LICENSE="freedist"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	emake || die "Compile failed"
}

src_install() {
	dobin as11
	dodoc as11.doc CHANGELOG README
}

