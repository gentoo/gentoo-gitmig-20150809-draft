# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_LDAP/PEAR-Net_LDAP-1.0.0.ebuild,v 1.8 2008/02/25 19:33:28 beandog Exp $

inherit php-pear-r1 depend.php

KEYWORDS="alpha amd64 hppa ppc sparc x86"

DESCRIPTION="OO interface for searching and manipulating LDAP-entries"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	require_php_with_use ldap
}
