# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/squid-cronolog/squid-cronolog-1.1.ebuild,v 1.1 2010/05/09 22:54:32 idl0r Exp $

EAPI=3

DESCRIPTION="cronolog wrapper for use with dumb daemons like squid"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/squid-cronolog.git"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-proxy/squid"
RDEPEND="${DEPEND}
	app-admin/cronolog"

src_install() {
	dosbin squid-cronolog || die

	newinitd squid-cronolog.initd squid-cronolog || die
	newconfd squid-cronolog.confd squid-cronolog || die

	dodir /var/lib || die
	mkfifo -m 600 "${D}/var/lib/squid-cronolog.fifo" || die
	fowners squid:squid /var/lib/squid-cronolog.fifo || die
}
