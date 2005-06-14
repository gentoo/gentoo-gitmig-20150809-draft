# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jlj/jlj-2.7.ebuild,v 1.1 2005/06/14 13:24:37 bass Exp $

DESCRIPTION="A simple console LiveJournal entry system."
HOMEPAGE="http://www.cis.rit.edu/~sdlpci/Software/perl/#jlj"
SRC_URI="http://www.cis.rit.edu/~sdlpci/Software/perl/${PN}_${PV}.tar.gz"
LICENSE="freedist"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}

src_install() {
	newbin ${PN}.pl ${PN} || die
	newdoc .livejournal.rc livejournal.rc
	dodoc README.JLJ
}

pkg_postinst() {
	einfo "README.JLJ and a sample livejournal.rc have been installed to"
	einfo "/usr/share/doc/${PF}/"
}
