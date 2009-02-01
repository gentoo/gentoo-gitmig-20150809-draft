# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendFramework/ZendFramework-1.7.2.ebuild,v 1.2 2009/02/01 12:20:54 maekke Exp $

PHP_LIB_NAME="Zend"

inherit php-lib-r1

KEYWORDS="amd64 ~hppa ~ppc ~ppc64 x86"

DESCRIPTION="Zend Framework is a high quality and open source framework for developing Web Applications."
HOMEPAGE="http://framework.zend.com/"
SRC_URI="!minimal? ( http://framework.zend.com/releases/${P}/${P}.tar.gz )
	minimal? ( http://framework.zend.com/releases/${P}/${P}-minimal.tar.gz )
	doc? (
		http://framework.zend.com/releases/${P}/${P}-apidoc.tar.gz
		http://framework.zend.com/releases/${P}/${P}-manual-en.tar.gz )"
LICENSE="BSD"
SLOT="0"
IUSE="doc examples minimal"

DEPEND=""
RDEPEND=""
need_php_by_category

src_unpack() {
	if use minimal ; then
		S="${WORKDIR}/${P}-minimal"
	fi

	unpack ${A}

	cd "${S}"
}

src_install() {
	php-lib-r1_src_install library/Zend $(cd library/Zend ; find . -type f -print)

	if use examples ; then
		insinto /usr/share/doc/${PF}

		if ! use minimal ; then
			doins -r demos
		fi
	fi

	dodoc README.txt
	if use doc ; then
		dohtml -r documentation/*
	fi
}

pkg_postinst() {
	elog "For more info, please take a look at the manual at:"
	elog "http://framework.zend.com/manual"
	elog ""

	if use minimal; then
		elog "You have installed the minimal version of ZendFramework,"
		elog "so the Dojo toolkit, demos and tests has not been installed."
	else
		elog "You have installed the full version of ZendFramework, which"
		elog "includde the Dojo toolkit, demos and tests."
		elog "To install without there, enable the minimal USE flag"
	fi
}
