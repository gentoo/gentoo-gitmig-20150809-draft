# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/znf/znf-0.7.6.ebuild,v 1.3 2006/04/19 01:37:53 weeve Exp $

inherit php-pear-lib-r1

KEYWORDS="~sparc ~x86"
DESCRIPTION="PHP5 MVC framework for enterprise web applications."
HOMEPAGE="http://znf.zeronotice.com/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="pear-db smarty"

MY_P="ZNF-${PV}"
SRC_URI="mirror://sourceforge/znf/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

RDEPEND="pear-db? ( >=dev-php/PEAR-DB-1.7.6-r1 )
		smarty? ( >=dev-php/smarty-2.6.10-r1 )"

need_php_by_category

pkg_setup() {
	has_php

	# we need XML/XSL support in PHP5 for this
	require_php_with_use xml xsl
}
