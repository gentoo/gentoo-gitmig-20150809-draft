# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jlj/jlj-2.12.ebuild,v 1.1 2006/11/19 03:34:27 dirtyepic Exp $

DESCRIPTION="A simple console LiveJournal entry system."
HOMEPAGE="http://umlautllama.com/projects/perl/#jlj"
SRC_URI="http://umlautllama.com/projects/perl/${PN}_${PV}.tar.gz"
LICENSE="freedist"
KEYWORDS="~x86"
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
