# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendOptimizer/ZendOptimizer-3.3.3-r1.ebuild,v 1.1 2008/05/09 13:10:00 hoffie Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="ZendOptimizer"
PHP_EXT_INI="yes"

inherit php-ext-base-r1

KEYWORDS="~amd64 ~x86"

SRC_URI="amd64? ( ${PN}-${PV}-linux-glibc23-x86_64.tar.gz )
	    x86? ( ${PN}-${PV}-linux-glibc23-i386.tar.gz )"

MY_ARCH=${ARCH/x86/glibc23-i386}
MY_ARCH=${MY_ARCH/amd64/glibc23-x86_64}

S="${WORKDIR}/${PN}-${PV}-linux-${MY_ARCH}"

DESCRIPTION="The Zend PHP optimizer and loader for encoded scripts."
HOMEPAGE="http://www.zend.com/products/zend_optimizer"
LICENSE="zend-optimizer"
SLOT="0"
IUSE=""

RESTRICT="mirror fetch strip"

DEPEND=""
RDEPEND="!dev-php5/xdebug !dev-php5/pecl-apc !dev-php5/eaccelerator"

need_php_by_category

pkg_nofetch() {
	einfo
	einfo "Please download ${PN}-${PV}-linux-${MY_ARCH} from:"
	einfo "${HOMEPAGE}"
	einfo "and put it into ${DISTDIR}."
	einfo "Please note that you need a valid Zend Account"
	einfo "(free) to download the Zend Optimizer!"
	einfo
}

pkg_setup() {
	php_binary_extension
	QA_TEXTRELS="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"
	QA_EXECSTACK="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"
}

src_install() {
	php-ext-base-r1_src_install

	if has_version =dev-lang/php-5.2* ; then
		ZENDOPT_VERSION_DIR="5_2_x_comp"
	else
		die "Unable to find an installed dev-lang/php-5* package."
	fi

	# Detect if we use ZTS and change the file path accordingly
	if has_zts ; then
		ZENDOPT_SO_FILE="data/${ZENDOPT_VERSION_DIR}/TS/${PHP_EXT_NAME}.so"
	else
		ZENDOPT_SO_FILE="data/${ZENDOPT_VERSION_DIR}/${PHP_EXT_NAME}.so"
	fi

	# Install the binary
	insinto ${EXT_DIR}
	doins ${ZENDOPT_SO_FILE}

	# Add the correct settings to the extension ini files
	php-ext-base-r1_addtoinifiles "zend_optimizer.optimization_level" "15"
	php-ext-base-r1_addtoinifiles "zend_optimizer.enable_loader" "1"
	php-ext-base-r1_addtoinifiles "zend_optimizer.disable_licensing" "0"

	dodoc-php README-${PN} data/doc/Zend_Optimizer_User_Guide.pdf
}

pkg_postinst() {
	has_php

	# You only need to restart apache2 if you're using mod_php
	if built_with_use =${PHP_PKG} apache2 ; then
		elog
		elog "You need to restart apache2 to activate the ${PN}."
		elog
	fi
}
