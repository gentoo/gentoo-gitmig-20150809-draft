# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Auth_SASL/PEAR-Auth_SASL-1.0.1-r1.ebuild,v 1.20 2009/11/24 14:42:40 beandog Exp $

inherit php-pear-r1

DESCRIPTION="Abstraction of various SASL mechanism responses"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""
DEPEND="|| ( <dev-php/PEAR-PEAR-1.71
	dev-php/PEAR-Console_Getopt )"
