# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.18.0.ebuild,v 1.8 2006/01/23 16:57:51 kloeri Exp $

inherit php-pear-r1

DESCRIPTION="Swiss-army knive for reading and writing XML files"

LICENSE="PHP"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Util-1.1.1-r1"
