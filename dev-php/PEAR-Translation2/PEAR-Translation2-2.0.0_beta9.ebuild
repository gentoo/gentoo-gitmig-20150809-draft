# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Translation2/PEAR-Translation2-2.0.0_beta9.ebuild,v 1.5 2006/05/27 11:11:09 chtekk Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Class for multilingual applications management."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_URI="http://pear.php.net/get/Translation2-2.0.0beta9.tgz"
S="${WORKDIR}/Translation2-2.0.0beta9"
RDEPEND="dev-php/PEAR-Cache_Lite
	dev-php/PEAR-DB
	dev-php/PEAR-DB_DataObject
	dev-php/PEAR-MDB
	dev-php/PEAR-MDB2
	dev-php/PEAR-File_Gettext
	dev-php/PEAR-I18Nv2
	dev-php/PEAR-XML_Serializer"

pkg_setup() {
	require_php_with_use nls
}
