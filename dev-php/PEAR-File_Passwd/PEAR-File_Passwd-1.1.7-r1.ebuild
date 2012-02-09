# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Passwd/PEAR-File_Passwd-1.1.7-r1.ebuild,v 1.5 2012/02/09 01:32:39 jer Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Manipulate many kinds of password files."

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
