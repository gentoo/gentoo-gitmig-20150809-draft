# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drraw/drraw-2.0.1.ebuild,v 1.1 2004/08/29 10:59:53 rl03 Exp $

inherit webapp

IUSE=""

DESCRIPTION="drraw is a simple web based presentation front-end for RRDtool that allows you to interactively build graphs of your own design"
HOMEPAGE="http://web.taranis.org/drraw"
SRC_URI="http://web.taranis.org/${PN}/dist/${P}.tgz"

KEYWORDS="~x86"

DEPEND="$DEPEND"
RDEPEND="
	${DEPEND}
	>=dev-lang/perl-5.6
	>=net-analyzer/rrdtool-1.0.47
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s|/usr/local/bin/perl|/usr/bin/perl|
		s|/drraw.conf|/../drraw.conf|" -i drraw.cgi
	sed -e "s|/somewhere/drraw/saved|/tmp|
		s|/somewhere/drraw/tmp|/tmp|" -i drraw.conf
}

src_install() {
	webapp_src_preinst
	dodoc CHANGES INSTALL README.EVENTS WISHLIST
	cp drraw.cgi ${D}/${MY_CGIBINDIR} && chmod +x ${D}/${MY_CGIBINDIR}/drraw.cgi
	cp drraw.conf ${D}/${MY_HOSTROOTDIR}
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
