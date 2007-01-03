# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drraw/drraw-2.1.3.ebuild,v 1.3 2007/01/03 00:40:55 rl03 Exp $

inherit webapp

IUSE=""

DESCRIPTION="drraw is a simple web based presentation front-end for RRDtool that allows you to interactively build graphs of your own design"
HOMEPAGE="http://web.taranis.org/drraw"
SRC_URI="http://web.taranis.org/${PN}/dist/${P}.tgz"

KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=dev-lang/perl-5.6
	virtual/perl-CGI
	>=net-analyzer/rrdtool-1.2.1
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s|/usr/local/bin/perl|/usr/bin/perl|" -i drraw.cgi
	sed -e "s|/somewhere/drraw/saved|/tmp|
		s|/somewhere/drraw/tmp|/tmp|" -i drraw.conf
}

src_install() {
	webapp_src_preinst
	dodoc CHANGES INSTALL README.EVENTS WISHLIST
	cp drraw.{cgi,conf} ${D}/${MY_CGIBINDIR}
	cp icons/* ${MY_ICONSDIR}

	webapp_configfile ${MY_CGIBINDIR}/drraw.conf

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
	chmod +x ${D}/${MY_CGIBINDIR}/drraw.cgi
}
