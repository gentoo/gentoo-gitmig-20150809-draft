# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Translation2/PEAR-Translation2-2.0.0_rc1.ebuild,v 1.1 2007/08/18 18:53:17 hoffie Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Class for multilingual applications management."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( dev-php/PEAR-Cache_Lite
			dev-php/PEAR-DB
			dev-php/PEAR-DB_DataObject
			dev-php/PEAR-MDB
			dev-php/PEAR-MDB2
			dev-php/PEAR-File_Gettext
			>=dev-php/PEAR-I18Nv2-0.9.1
			>=dev-php/PEAR-XML_Serializer-0.13.0 )"

pkg_setup() {
	require_php_with_use nls
}
