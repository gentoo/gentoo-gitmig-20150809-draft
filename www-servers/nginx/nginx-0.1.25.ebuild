# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/nginx/nginx-0.1.25.ebuild,v 1.1 2005/03/19 16:44:08 voxus Exp $

inherit eutils

DESCRIPTION="Robust, small and high performance http and reverse proxy server"

HOMEPAGE="http://sysoev.ru/nginx/"
SRC_URI="http://sysoev.ru/nginx/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl zlib threads"

DEPEND="dev-lang/perl
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

src_compile() {
	local myconf

	use ssl				&& myconf="${myconf} --with-http_ssl_module"

	if use threads; then
		einfo
		ewarn "threads support is experimental at the moment"
		ewarn "do not use it on production systems - you've been warned"
		einfo
		myconf="${myconf} --with-threads"
	fi

	use zlib			|| myconf="${myconf} --without-http_gzip_module"

#	use charset-mod		|| myconf = "${myconf} --without-http_charset_module"
#	use userid-mod		|| myconf = "${myconf} --without-http_userid_module"
#	use access-mod		|| myconf = "${myconf} --without-http_access_module"
#	use autoindex-mod	|| myconf = "${myconf} --without-http_autoindex_module"
#	use geo-mod			|| myconf = "${myconf} --without-http_geo_module"
#	use rewrite-mod		|| myconf = "${myconf} --without-http_rewrite_module"
#	use proxy-mod		|| myconf = "${myconf} --without-http_proxy_module"
#	use fastcgi-mod		|| myconf = "${myconf} --without-http_fastcgi_module"

	cd ${S}
	./configure												\
		--prefix=/usr										\
		--conf-path=/etc/${PN}/${PN}.conf					\
		--http-log-path=/var/log/${PN}/access_log			\
		--error-log-path=/var/log/${PN}/error_log			\
		--pid-path=/var/run/${PN}.pid						\
		--http-client-body-temp-path=/var/tmp/${PN}/client	\
		--http-proxy-temp-path=/var/tmp/${PN}/proxy			\
		--http-fastcgi-temp-path=/var/tmp/${PN}/fastcgi		\
		--with-md5-asm										\
		${myconf}

	emake || "failed to compile"
}

src_install() {
	cd ${S} || die

	dodir /var/log/${PN}
	keepdir /var/log/${PN}

	dodir /var/tmp/${PN}

	dodir /var/tmp/${PN}/client
	keepdir /var/tmp/${PN}/client

	dodir /var/tmp/${PN}/proxy
	keepdir /var/tmp/${PN}/proxy

	dodir /var/tmp/${PN}/fastcgi
	keepdir /var/tmp/${PN}/fastcgi

	dodir /etc/${PN}

	dosbin objs/nginx
	doinitd ${FILESDIR}/nginx

	insinto /etc/${PN}
	rm conf/nginx.conf
	doins -r conf/*
	doins ${FILESDIR}/nginx.conf

	dodoc CHANGES{,.ru} LICENSE README
}
