# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sendEmail/sendEmail-1.42.ebuild,v 1.4 2004/09/10 10:04:27 humpback Exp $

DESCRIPTION="Command line based, SMTP email agent"

HOMEPAGE="http://caspian.dotconf.net/menu/Software/SendEmail/"

SRC_URI="http://caspian.dotconf.net/menu/Software/SendEmail/${PN}-v${PV}.tar.gz"

LICENSE="as-is"

SLOT="0"

KEYWORDS="x86 ~ppc"

IUSE=""

DEPEND=""

RDEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}-v${PV}


src_install() {
	dodir /usr/bin
	exeinto /usr/bin ; doexe sendEmail
	dodoc CHANGELOG  README  TODO
}
