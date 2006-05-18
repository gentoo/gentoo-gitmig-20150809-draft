# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.18.0.ebuild,v 1.15 2006/05/18 05:50:25 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Swiss-army knife for reading and writing XML files"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Util-1.1.1-r1"

pkg_setup() {
	require_php_with_use xml
}
