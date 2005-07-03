# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ntlmaps/ntlmaps-0.9.9.5.ebuild,v 1.1 2005/07/03 08:57:13 mrness Exp $

inherit eutils

DESCRIPTION="NTLM proxy Authentication against MS proxy/web server"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	#stupid windoze style
	sed -i -e 's/\r//' lib/*.py server.cfg doc/*.{txt,htm}
}

src_install() {
	# exes ------------------------------------------------------------------
	exeinto /usr/bin
	newexe main.py ${PN} || die "failed to install main program"
	insinto /usr/lib/${PN}
	doins lib/* || die "failed to install python modules"
	# doc -------------------------------------------------------------------
	dodoc *.txt doc/*.txt
	dohtml doc/*
	# conf ------------------------------------------------------------------
	insinto /etc/${PN}
	doins server.cfg
	newinitd ${FILESDIR}/${PN}.init ${PN}
	# log -------------------------------------------------------------------
	diropts -m 0770 -g nobody
	keepdir /var/log/${PN}
}

pkg_prerm() {
	einfo "Removing python compiled bytecode"
	rm -f /usr/lib/${PN}/*.py?
}
