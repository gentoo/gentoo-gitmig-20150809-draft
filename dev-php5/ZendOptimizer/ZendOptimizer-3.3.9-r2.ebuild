# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendOptimizer/ZendOptimizer-3.3.9-r2.ebuild,v 1.1 2010/11/04 19:39:38 mabi Exp $

EAPI="3"

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="ZendOptimizer"
PHP_EXT_INI="yes"
USE_PHP="php5-2"

inherit php-ext-source-r2

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
		 dev-lang/php:5.2[-debug,-threads]"

QA_TEXTRELS="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"
QA_EXECSTACK="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"

pkg_nofetch() {
	elog
	elog "Please download ${PN}-${PV}-linux-${MY_ARCH} from:"
	elog "${HOMEPAGE}"
	elog "and put it into ${DISTDIR}."
	elog "Please note that you need a valid Zend Account"
	elog "(free) to download the Zend Optimizer!"
	elog
}

src_prepare() {
	true # no configuration neccessary
}

src_configure() {
	true # binary package, nothing to configure
}

src_compile() {
	true # binary package, nothing to compile
}

src_install() {
	php-ext-source-r2_createinifiles

	ZENDOPT_VERSION_DIR="5_2_x_comp"
	ZENDOPT_SO_FILE="data/${ZENDOPT_VERSION_DIR}/${PHP_EXT_NAME}.so"

	# Install the binary
	insinto ${EXT_DIR}
	doins ${ZENDOPT_SO_FILE}

	# Add the correct settings to the extension ini files
	php-ext-source-r2_addtoinifiles "zend_optimizer.optimization_level" "15"
	php-ext-source-r2_addtoinifiles "zend_optimizer.enable_loader" "1"
	php-ext-source-r2_addtoinifiles "zend_optimizer.disable_licensing" "0"

	dodoc README-${PN}
}

pkg_postinst() {
	# You only need to restart apache2 if you're using mod_php
	if has_version dev-lang/php:5.2[apache2] ; then
		elog
		elog "You need to restart apache2 to activate the ${PN}."
		elog
	fi
}
