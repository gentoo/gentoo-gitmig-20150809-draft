# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircmap/ircmap-0.99.ebuild,v 1.9 2004/07/24 01:48:22 swegener Exp $

DESCRIPTION="This script connects to the specified IRC server and creates a diagram of the network performing LINKS command."
HOMEPAGE="http://pasky.ji.cz/~pasky/irc/"
SRC_URI="http://pasky.ji.cz/~pasky/irc/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/libc
	media-gfx/graphviz
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_compile() {
	eval `perl -V:installprivlib`

	sed -i \
		-e "s:/home/pasky/ircmap:${installprivlib}/ircmap:" \
		{ircmapC,ircmapR-aa,ircmapR-gvdot,ircmapR-ircnet,ircmapS}.pl
}

src_install () {
	dodoc README
	dobin ircmapS.pl ircmapC.pl ircmapR-aa.pl ircmapR-gvdot.pl ircmapR-ircnet.pl

	eval `perl -V:installprivlib`

	insinto ${D}/${installprivlib}/ircmap
	doins IHash.pm
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
