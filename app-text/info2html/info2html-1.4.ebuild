# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/info2html/info2html-1.4.ebuild,v 1.11 2007/01/28 05:50:39 genone Exp $

inherit eutils webapp-apache

DESCRIPTION="Converts GNU .info files to HTML"
HOMEPAGE="http://info2html.sourceforge.net/"
SRC_URI="mirror://sourceforge/info2html/${P}.tgz"

LICENSE="freedist"
SLOT="0"
IUSE=""
KEYWORDS="alpha hppa sparc x86 amd64"

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
	elog "Info files can be found at:"
	elog "\thttp://localhost/cgi-bin/infocat"
}
