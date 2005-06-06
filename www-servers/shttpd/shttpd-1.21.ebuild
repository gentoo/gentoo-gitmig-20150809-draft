# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/shttpd/shttpd-1.21.ebuild,v 1.1 2005/06/06 14:17:42 ka0ttic Exp $

inherit eutils toolchain-funcs

MY_P="${P/-/_}"
DESCRIPTION="Small and embeddable HTTPD server with CGI support"
HOMEPAGE="http://shttpd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.c"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )"

src_unpack() {
	mkdir ${S}
	cp ${DISTDIR}/${MY_P}.c ${S}
}

src_compile() {
	local opts
	CC=$(tc-getCC)

	if use ssl ; then
		opts="-DWITH_SSL ${MY_P}.c -o ${PN} -lcrypto -lssl"
	else
		opts="${MY_P}.c -o ${PN}"
	fi

	echo "${CC} ${opts}"
	${CC} ${opts} || die "compile failure"
}

src_install() {
	keepdir /var/log/shttpd
	dosbin ${PN} || die

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN} || die
	newinitd ${FILESDIR}/${PN}.initd ${PN} || die
	newconfd ${FILESDIR}/${PN}.confd ${PN} || die
}

pkg_postinst() {
	enewgroup shttpd
	enewuser shttpd -1 /bin/false /var/www/localhost/htdocs shttpd
	einfo
	einfo "You can run shttpd standalone or in xinetd mode."
	einfo "Please read http://shttpd.sourceforge.net/ for more info!"
	einfo
}
