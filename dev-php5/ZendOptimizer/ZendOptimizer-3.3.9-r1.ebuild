# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendOptimizer/ZendOptimizer-3.3.9-r1.ebuild,v 1.1 2010/06/22 21:26:59 mabi Exp $

EAPI="2"

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
RDEPEND="!dev-php5/xdebug
		 !dev-php5/pecl-apc
		 <dev-lang/php-5.3[-debug,-threads]"

need_php_by_category

pkg_nofetch() {
	elog
	elog "Please download ${PN}-${PV}-linux-${MY_ARCH} from:"
	elog "${HOMEPAGE}"
	elog "and put it into ${DISTDIR}."
	elog "Please note that you need a valid Zend Account"
	elog "(free) to download the Zend Optimizer!"
	elog
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

	ZENDOPT_SO_FILE="data/${ZENDOPT_VERSION_DIR}/${PHP_EXT_NAME}.so"

	# Install the binary
	insinto ${EXT_DIR}
	doins ${ZENDOPT_SO_FILE}

	# Add the correct settings to the extension ini files
	php-ext-base-r1_addtoinifiles "zend_optimizer.optimization_level" "15"
	php-ext-base-r1_addtoinifiles "zend_optimizer.enable_loader" "1"
	php-ext-base-r1_addtoinifiles "zend_optimizer.disable_licensing" "0"

	dodoc-php README-${PN}
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
