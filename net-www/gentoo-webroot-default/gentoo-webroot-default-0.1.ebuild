# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gentoo-webroot-default/gentoo-webroot-default-0.1.ebuild,v 1.5 2005/01/23 07:32:04 trapni Exp $

DESCRIPTION="This is the default Gentoo WebServer content"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
S=${WORKDIR}/${PF}


src_install() {
	insinto /var/www/localhost/
	doins -r webroot/htdocs

	dodoc AUTHORS README TODO
}
