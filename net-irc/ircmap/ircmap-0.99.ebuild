# Copyright 2002 Paul Belt
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircmap/ircmap-0.99.ebuild,v 1.2 2003/07/13 12:54:50 aliz Exp $

IUSE=""

DESCRIPTION="This script connects to the specified IRC server and creates a
diagram of the network performing LINKS command."
HOMEPAGE="http://pasky.ji.cz/~pasky/irc/"
SRC_URI="http://pasky.ji.cz/~pasky/irc/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RDEPEND="virtual/glibc
         media-gfx/graphviz"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}

src_compile() {
	for myfile in ircmapC ircmapR-aa ircmapR-gvdot ircmapR-ircnet ircmapS
	do
		mv ${myfile}.pl ${myfile}.unpatched
			sed -e 's!/home/pasky/ircmap!/usr/lib/perl5/site_perl/5.6.1/ircmap!' \
			${myfile}.unpatched > ${myfile}.pl
		rm ${myfile}.unpatched
	done
}


src_install () {
	dodoc README
	dobin ircmapS.pl ircmapC.pl ircmapR-aa.pl ircmapR-gvdot.pl ircmapR-ircnet.pl

	mkdir -p ${D}/usr/lib/perl5/site_perl/5.6.1/ircmap
	cp IHash.pm ${D}/usr/lib/perl5/site_perl/5.6.1/ircmap/
}

pkg_postinst() {
	einfo 'Usage:'
	einfo 'IRCSERVER="irc.generic.com ircmapS.pl [-options parameters] \'
	einfo '| tee /tmp/sendmethisifitdoesntwork \'
	einfo '| ircmapC.pl \'
	einfo '| tee /tmp/coredump \'
	einfo '| ircmapR-aa.pl > ${IRCSERVER}.txt'
	einfo ''
	einfo 'cat /tmp/coredump \'
	einfo '| ircmapR-gvdot.pl \'
	einfo '| dot -Tgif -o  ${IRCSERVER}.gif'
}
