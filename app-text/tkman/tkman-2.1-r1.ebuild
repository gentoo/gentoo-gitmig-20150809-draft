# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.1-r1.ebuild,v 1.7 2004/02/29 18:10:26 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TkMan man and info page browser"
SRC_URI="http://tkman.sourceforge.net/${PN}.tar.gz"
HOMEPAGE="http://tkman.sourceforge.net/"
KEYWORDS="x86 ppc sparc"
SLOT="0"
LICENSE="Artistic"

DEPEND=">=app-text/rman-3.0.9
	>=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff

	# A workaround until app-text/rman-3.1 is stable
	has_version '>=sys-apps/groff-1.18' \
		has_version '<app-text/rman-3.1' \
		&& sed -i -e "s:groff -te -Tlatin1:groff -P -c -te -Tlatin1:" ${S}/Makefile

}

src_compile() {
	emake || die
}

src_install () {
	dobin ${PN}
	dobin re${PN}
}
