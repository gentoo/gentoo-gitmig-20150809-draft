# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-openid/php-openid-2.1.3.ebuild,v 1.2 2010/01/02 23:26:59 yngwin Exp $

EAPI="2"
inherit php-lib-r1

PHP_LIB_NAME="Auth"
DESCRIPTION="PHP OpenID implementation"
HOMEPAGE="http://openidenabled.com/php-openid/"
SRC_URI="http://openidenabled.com/files/php-openid/packages/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="|| ( dev-lang/php[bcmath] dev-lang/php[gmp] )
	dev-lang/php[curl]"

src_install() {
	cd "${S}"/Auth
	php-lib-r1_src_install . * */*

	if use examples; then
		cd "${S}"
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
