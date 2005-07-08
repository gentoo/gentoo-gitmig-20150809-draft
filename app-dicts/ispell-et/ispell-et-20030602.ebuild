# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-et/ispell-et-20030602.ebuild,v 1.2 2005/07/08 13:34:12 dholm Exp $

DESCRIPTION="Estonian dictionary for ispell"
HOMEPAGE="http://www.meso.ee/~jjpp/speller/"
SRC_URI="http://www.meso.ee/~jjpp/speller/estonian.aff
	http://www.meso.ee/~jjpp/speller/estonian.dict"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-text/ispell"
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	cp ${DISTDIR}/estonian.dict ${S}
	cp ${DISTDIR}/estonian.aff ${S}
}

src_compile() {
	buildhash estonian.dict estonian.aff estonian.hash
}

src_install() {
	insinto /usr/lib/ispell
	doins estonian.aff estonian.hash
}
