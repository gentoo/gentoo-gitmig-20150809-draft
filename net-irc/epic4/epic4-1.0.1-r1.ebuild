# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.0.1-r1.ebuild,v 1.8 2002/07/23 07:39:06 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Epic4 IRC Client"
SRC_URI="ftp://epicsol.org/pub/epic/EPIC4-PRODUCTION/${P}.tar.gz \
	ftp://epicsol.org/pub/epic/EPIC4-BETA/epic4pre2-help.tar.gz"
HOMEPAGE="http://epicsol.org"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_compile() {
	econf --libexecdir=/usr/lib/misc || die

	make || die
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die

	rm ${D}/usr/bin/epic
	dosym epic-EPIC4-${PV} /usr/bin/epic
	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
	docinto doc
	cd doc
	dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
	dodoc nicknames outputhelp server_groups SILLINESS TS4
	dodir /usr/share/epic
	tar xzvf ${DISTDIR}/epic4pre2-help.tar.gz -C ${D}/usr/share/epic
}
