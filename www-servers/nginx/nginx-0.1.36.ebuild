# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/nginx/nginx-0.1.36.ebuild,v 1.1 2005/06/16 09:00:49 voxus Exp $

inherit eutils

DESCRIPTION="Robust, small and high performance http and reverse proxy server"

HOMEPAGE="http://sysoev.ru/nginx/"
SRC_URI="http://sysoev.ru/nginx/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug fastcgi pcre threads ssl zlib"

DEPEND="dev-lang/perl
	pcre? ( >=dev-libs/libpcre-4.2 )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ppc && epatch ${FILESDIR}/nginx-0.1.35-ppc.patch
}

src_compile() {
	local myconf

	if use threads; then
		einfo
		ewarn "threads support is experimental at the moment"
		ewarn "do not use it on production systems - you've been warned"
		einfo
		myconf="${myconf} --with-threads"
	fi

	use fastcgi	|| myconf="${myconf} --without-http_fastcgi_module"
	use zlib	|| myconf="${myconf} --without-http_gzip_module"
	use pcre	|| myconf="${myconf} --without-pcre"
	use debug	&& myconf="${myconf} --with-debug"
	use ssl		&& myconf="${myconf} --with-http_ssl_module"

	cd ${S} && ./configure									\
		--prefix=/usr										\
		--conf-path=/etc/${PN}/${PN}.conf					\
		--http-log-path=/var/log/${PN}/access_log			\
		--error-log-path=/var/log/${PN}/error_log			\
		--pid-path=/var/run/${PN}.pid						\
		--http-client-body-temp-path=/var/tmp/${PN}/client	\
		--http-proxy-temp-path=/var/tmp/${PN}/proxy			\
		--http-fastcgi-temp-path=/var/tmp/${PN}/fastcgi		\
		--with-md5-asm										\
		${myconf} || die "configure failed"

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
