# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/info2html/info2html-1.4.ebuild,v 1.8 2004/11/21 14:51:25 sekretarz Exp $

inherit eutils webapp-apache

DESCRIPTION="Converts GNU .info files to HTML"
HOMEPAGE="http://info2html.sourceforge.net/"
SRC_URI="mirror://sourceforge/info2html/${P}.tgz"

LICENSE="freedist"
SLOT="0"
IUSE=""
KEYWORDS="alpha hppa sparc x86 ~amd64"

DEPEND="dev-lang/perl"

pkg_setup() {
	webapp-detect || NO_HTTPD=1
	webapp-pkg_setup "${NO_HTTPD}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/info2html-gentoo.patch
}

src_install() {
	webapp-mkdirs

	exeinto ${HTTPD_CGIBIN}
	doexe info2html infocat
	insinto ${HTTPD_CGIBIN}
	doins info2html.conf
	dodoc README
}

pkg_postinst() {
	einfo "Info files can be found at:"
	einfo "\thttp://localhost/cgi-bin/infocat"
}
