# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/ntlmaps/ntlmaps-0.9.9.ebuild,v 1.2 2005/04/02 10:56:23 blubb Exp $

inherit eutils

DESCRIPTION="NTLM proxy Authentication against MS proxy/web server"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~ia64 ~ppc ~s390 ~x86 ~ppc64 ~amd64"
IUSE=""

DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	sed -i -e 's/\r//' server.cfg *.txt doc/*.txt # stupid windoze style
}

src_install() {
	# exes ------------------------------------------------------------------
	exeinto /usr/bin
	newexe main.py ${PN} || die
	insinto /usr/lib/${PN}
	doins lib/* || die
	# doc -------------------------------------------------------------------
	dodoc *.txt doc/*.txt
	dohtml doc/*
	# conf ------------------------------------------------------------------
	insinto /etc/${PN}
	doins server.cfg
	newinitd ${FILESDIR}/${PN}.init ${PN}
}
pkg_prerm() {
	einfo "Removing init script and python compiled bytecode"
	rm -f /usr/lib/${PN}/*.py?
	rm -f /etc/init.d/${PN}
}
