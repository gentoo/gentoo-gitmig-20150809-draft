# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB/PEAR-DB-1.7.6-r1.ebuild,v 1.20 2010/02/15 01:29:29 beandog Exp $

inherit php-pear-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="Database abstraction layer for PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="|| ( <dev-php/PEAR-PEAR-1.71
	dev-php/PEAR-Console_Getopt )"
RDEPEND=""
