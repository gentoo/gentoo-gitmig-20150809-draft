# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-http/pecl-http-1.6.0.ebuild,v 1.3 2008/05/05 20:54:11 maekke Exp $

PHP_EXT_NAME="http"
PHP_EXT_PECL_PKG="pecl_http"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/tutorial.txt ThanksTo.txt KnownIssues.txt"

inherit php-ext-pecl-r1 php-ext-base-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Extended HTTP Support for PHP."
LICENSE="BSD-2 MIT"
SLOT="0"
IUSE=""

DEPEND=">=net-misc/curl-7.16.4
	sys-libs/zlib
	dev-libs/libevent"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--enable-http \
			--with-http-curl-requests \
			--with-http-zlib-compression \
			--with-http-curl-libevent \
			--with-http-magic-mime"

	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install

	php-ext-base-r1_addtoinifiles "http.etag.mode" "MD5"
	php-ext-base-r1_addtoinifiles "http.force_exit" "1"
	php-ext-base-r1_addtoinifiles "http.log.allowed_methods" ""
	php-ext-base-r1_addtoinifiles "http.log.cache" ""
	php-ext-base-r1_addtoinifiles "http.log.composite" ""
	php-ext-base-r1_addtoinifiles "http.log.not_found" ""
	php-ext-base-r1_addtoinifiles "http.log.redirect" ""
	php-ext-base-r1_addtoinifiles "http.only_exceptions" "0"
	php-ext-base-r1_addtoinifiles "http.persistent.handles.ident" "GLOBAL"
	php-ext-base-r1_addtoinifiles "http.persistent.handles.limit" "-1"
	php-ext-base-r1_addtoinifiles "http.request.datashare.connect" "0"
	php-ext-base-r1_addtoinifiles "http.request.datashare.cookie" "0"
	php-ext-base-r1_addtoinifiles "http.request.datashare.dns" "1"
	php-ext-base-r1_addtoinifiles "http.request.datashare.ssl" "0"
	php-ext-base-r1_addtoinifiles "http.request.methods.allowed" ""
	php-ext-base-r1_addtoinifiles "http.request.methods.custom" ""
	php-ext-base-r1_addtoinifiles "http.send.inflate.start_auto" "0"
	php-ext-base-r1_addtoinifiles "http.send.inflate.start_flags" "0"
	php-ext-base-r1_addtoinifiles "http.send.deflate.start_auto" "0"
	php-ext-base-r1_addtoinifiles "http.send.deflate.start_flags" "0"
	php-ext-base-r1_addtoinifiles "http.send.not_found_404" "1"
}

pkg_postinst() {
	has_php
	if ! built_with_use --missing true =${PHP_PKG} hash iconv session spl ; then
		elog "${PN} can optionally use hash, iconv, session and spl features."
		elog "If you want those, recompile ${PHP_PKG} with those flags in USE."
	fi
}
