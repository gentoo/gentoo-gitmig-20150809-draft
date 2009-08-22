# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Passwd/PEAR-File_Passwd-1.1.7.ebuild,v 1.1 2009/08/22 18:48:06 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Manipulate many kinds of password files."
LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"
RDEPEND="!minimal? ( dev-php/PEAR-Crypt_CHAP )"

pkg_setup() {
	require_php_with_use pcre
}
