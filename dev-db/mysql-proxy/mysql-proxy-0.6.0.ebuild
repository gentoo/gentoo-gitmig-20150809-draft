# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-proxy/mysql-proxy-0.6.0.ebuild,v 1.2 2007/10/03 19:50:17 swegener Exp $

inherit eutils

DESCRIPTION="A Proxy for the MySQL Client/Server protocol"
HOMEPAGE="http://forge.mysql.com/wiki/MySQL_Proxy"
SRC_URI="mirror://mysql/Downloads/MySQL-Proxy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="lua examples"
DEPEND=">=dev-libs/libevent-1.0
	>=dev-libs/glib-2.0
	>=virtual/mysql-4.0
	lua? ( >=dev-lang/lua-5.1 )"

src_compile() {
	econf \
		--with-mysql \
		$(use_with lua) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dosbin src/mysql-proxy
	if useq lua; then
		insinto /usr/share/${PN}
		doins lib/*.lua
		insinto /usr/share/${PN}/proxy
		doins lib/proxy/*.lua
		if useq examples; then
			insinto /usr/share/${PN}/examples
			doins examples/*.lua
		fi
	fi
	dodoc README INSTALL NEWS
	newinitd "${FILESDIR}/${PV}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PV}/${PN}.confd" ${PN}
}

pkg_postinst() {
	einfo
	einfo "You might want to have a look at"
	einfo "http://dev.mysql.com/tech-resources/articles/proxy-gettingstarted.html"
	einfo "on how to get started with MySQL Proxy."
	einfo
}
