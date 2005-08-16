# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/shttpd/shttpd-1.25.ebuild,v 1.2 2005/08/16 13:18:09 metalgod Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Small and embeddable HTTPD server with (optional) CGI support"
HOMEPAGE="http://shttpd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl cgi threads dmalloc"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )
	dmalloc? ( >=dev-libs/dmalloc-5.3.0 )"
RDEPEND="${DEPEND}
	app-misc/mime-types"

src_compile() {
	local libs
	CC=$(tc-getCC)

	if use ssl ; then
		libs="${libs} -lcrypto -lssl"
		append-flags -DWITH_SSL
	fi

	if use dmalloc ; then
		libs="${libs} -ldmalloc"
		append-flags -DWITH_DMALLOC
	fi

	use cgi || append-flags -DNO_CGI
	use threads && append-flags -DMT

	append-flags -DCONFIG=\"/etc/${PN}/${PN}.conf\" -DWITH_PUT_AND_DELETE
	echo "${CC} ${CFLAGS} ${PN}.c -o ${PN} ${LDFLAGS} ${libs}"
	${CC} ${CFLAGS} ${PN}.c -o ${PN} ${LDFLAGS} ${libs} || die "compile failure"
}

src_install() {
	keepdir /var/log/${PN}
	dosbin ${PN} || die
	doman ${PN}.1 || die

	insinto /etc/${PN}
	doins ${FILESDIR}/${PN}.conf ${PN}.pem || die

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN} || die
	newinitd ${FILESDIR}/${PN}.initd ${PN} || die
	newconfd ${FILESDIR}/${PN}.confd ${PN} || die

	docinto embed
	dodoc embed/* shttpd.c
}

pkg_postinst() {
	enewgroup shttpd
	enewuser shttpd -1 /bin/false /var/www/localhost/htdocs shttpd
	einfo
	einfo "You can run shttpd standalone or in xinetd mode."
	einfo "Don't forget to edit /etc/shttpd/shttpd.conf."
	einfo "Please read http://shttpd.sourceforge.net/ for more info!"
	einfo
}
