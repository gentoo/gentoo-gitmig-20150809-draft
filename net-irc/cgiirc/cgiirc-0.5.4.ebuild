# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cgiirc/cgiirc-0.5.4.ebuild,v 1.1 2004/05/31 15:21:30 mholzer Exp $

IUSE=""

inherit webapp

DESCRIPTION="A perl/CGI program to use IRC from a web browser"
HOMEPAGE="http://cgiirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A}

	find ${S} -name .cvsignore -exec rm {} \;
}

src_install() {
	webapp_src_preinst

	local docs="README cgiirc.config.full ipaccess.example"

	dodoc docs/{CHANGES,COPYING,TODO} ${docs}
	dohtml docs/help.html
	rm -rf docs ${docs}

	echo "Options +ExecCGI" >>.htaccess

	cp -R . ${D}/${MY_HTDOCSDIR}
	webapp_configfile ${MY_HTDOCSDIR}/cgiirc.config

	webapp_src_install
}
