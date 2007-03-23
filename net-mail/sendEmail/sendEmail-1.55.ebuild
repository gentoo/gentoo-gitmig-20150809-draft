# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sendEmail/sendEmail-1.55.ebuild,v 1.2 2007/03/23 08:40:07 mrness Exp $

DESCRIPTION="Command line based, SMTP email agent"
HOMEPAGE="http://caspian.dotconf.net/menu/Software/SendEmail/"
SRC_URI="http://caspian.dotconf.net/menu/Software/SendEmail/${PN}-v${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ssl"

DEPEND=""
RDEPEND="dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL )"

S="${WORKDIR}/${PN}-v${PV}"

src_install() {
	dodir /usr/bin
	exeinto /usr/bin ; doexe sendEmail
	dodoc CHANGELOG  README  TODO
}
