# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cgiirc/cgiirc-0.5.8.ebuild,v 1.1 2006/05/01 14:13:20 rl03 Exp $

IUSE=""

inherit webapp

DESCRIPTION="A perl/CGI program to use IRC from a web browser"
HOMEPAGE="http://cgiirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_unpack() {
	einfo "Note that file locations have changed."
	einfo "CGI:IRC will be installed into cgi-bin/${P}"
	unpack ${A}
	find ${S} -name .cvsignore -exec rm {} \;
}

src_install() {
	webapp_src_preinst

	local docs="README cgiirc.config.full ipaccess.example"

	dodoc docs/{CHANGES,TODO} ${docs}
	dohtml docs/help.html

	dodir ${MY_CGIBINDIR}/${P}

	cp -R . ${D}/${MY_CGIBINDIR}/${P}

	cd ${D}/${MY_CGIBINDIR}/${P}
	rm -rf docs ${docs}

	webapp_configfile ${MY_CGIBINDIR}/${P}/cgiirc.config

	webapp_src_install
}
