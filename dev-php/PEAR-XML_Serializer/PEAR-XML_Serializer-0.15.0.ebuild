# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.15.0.ebuild,v 1.11 2005/06/18 10:43:40 hansmi Exp $

inherit php-pear

DESCRIPTION="Swiss-army knive for reading and writing XML files"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="dev-php/PEAR-PEAR
	>=dev-php/PEAR-XML_Parser-1.2.1
	>=dev-php/PEAR-XML_Util-1.1.1"
