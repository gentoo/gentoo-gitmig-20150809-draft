# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jlj/jlj-2.5.ebuild,v 1.1 2004/08/01 17:34:00 bass Exp $

DESCRIPTION="A simple console LiveJournal entry system."
HOMEPAGE="http://www.cis.rit.edu/~sdlpci/Software/perl/#jlj"
SRC_URI="http://www.cis.rit.edu/~sdlpci/Software/perl/${PN}_${PV}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}

src_install() {
	newbin ${PN}.pl ${PN} || die
	doman ${FILESDIR}/${PN}.1
	dodoc README.JLJ
	einfo
	einfo "You must now setup a .livejournal.rc file in your home directory"
	einfo "with your user name and password in the following format:"
	einfo "    user: ljname"
	einfo "    password: mypass"
	einfo
}
