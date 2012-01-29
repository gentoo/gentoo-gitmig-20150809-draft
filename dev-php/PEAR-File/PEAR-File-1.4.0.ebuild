# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File/PEAR-File-1.4.0.ebuild,v 1.5 2012/01/29 15:20:49 armin76 Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Common file and directory routines"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
