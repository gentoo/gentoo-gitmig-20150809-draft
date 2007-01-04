# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jlj/jlj-2.12.ebuild,v 1.2 2007/01/04 15:42:28 kloeri Exp $

DESCRIPTION="A simple console LiveJournal entry system."
HOMEPAGE="http://umlautllama.com/projects/perl/#jlj"
SRC_URI="http://umlautllama.com/projects/perl/${PN}_${PV}.tar.gz"
LICENSE="freedist"
KEYWORDS="~alpha ~x86"
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
	elog "README.JLJ and a sample livejournal.rc have been installed to"
	elog "/usr/share/doc/${PF}/"
}
