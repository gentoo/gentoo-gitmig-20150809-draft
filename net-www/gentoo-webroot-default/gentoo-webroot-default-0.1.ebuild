# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gentoo-webroot-default/gentoo-webroot-default-0.1.ebuild,v 1.2 2005/01/22 06:06:58 trapni Exp $


DESCRIPTION="This is the default Gentoo WebServer content"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~trapni/dist/${PF}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_install() {
	insinto /var/www/localhost/htdocs
	doins ${WORKDIR}/${PF}/htdocs/index.html
	doins ${WORKDIR}/${PF}/htdocs/gentoo-logo.png
}
