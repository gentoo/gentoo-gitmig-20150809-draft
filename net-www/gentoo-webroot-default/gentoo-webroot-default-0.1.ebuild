# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gentoo-webroot-default/gentoo-webroot-default-0.1.ebuild,v 1.7 2005/01/28 17:03:19 hollow Exp $

DESCRIPTION="This is the default Gentoo WebServer content"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="no-htdocs"
DEPEND=""
S=${WORKDIR}/${PF}


src_install() {
	if useq no-htdocs; then
		insinto /usr/share/doc/${PF}/webroot/
	else
		insinto /var/www/localhost/
	fi
	doins -r webroot/htdocs
	doins -r webroot/icons
	doins -r webroot/cgi-bin

	dodoc AUTHORS README TODO
}

pkg_postinst() {
	if useq no-htdocs; then
		einfo "Default webroot not installed into /var/www/localhost."
		einfo "Execute \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
		einfo "to install it there."
	fi
}

pkg_config() {
	cp -r /usr/share/doc/${PF}/webroot/htdocs /var/www/localhost
}

