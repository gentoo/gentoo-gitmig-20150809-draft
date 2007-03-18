# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/znf/znf-0.7.6.ebuild,v 1.4 2007/03/18 03:21:08 chtekk Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~sparc ~x86"

MY_P="ZNF-${PV}"

DESCRIPTION="PHP5 MVC framework for enterprise web applications."
HOMEPAGE="http://znf.zeronotice.com/"
SRC_URI="mirror://sourceforge/znf/${MY_P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="pear-db smarty"

DEPEND=""
RDEPEND="pear-db? ( >=dev-php/PEAR-DB-1.7.6-r1 )
		smarty? ( >=dev-php/smarty-2.6.10-r1 )"

S="${WORKDIR}/${MY_P}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use xml xsl
}
