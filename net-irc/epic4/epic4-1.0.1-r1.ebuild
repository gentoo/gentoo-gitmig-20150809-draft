# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.0.1-r1.ebuild,v 1.7 2002/07/16 04:54:33 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Epic4 IRC Client"
SRC_URI="ftp://epicsol.org/pub/epic/EPIC4-PRODUCTION/epic4-1.0.1.tar.gz \
	ftp://epicsol.org/pub/epic/EPIC4-BETA/epic4pre2-help.tar.gz"
HOMEPAGE="http://epicsol.org"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_unpack () {
	unpack epic4-1.0.1.tar.gz
}


src_compile() {
	econf \
		--libexecdir=/usr/lib/misc || die

	make || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		libexecdir=${D}/usr/lib/misc \
		install || die

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
