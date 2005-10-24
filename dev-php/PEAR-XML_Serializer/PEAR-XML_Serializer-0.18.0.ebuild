# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.18.0.ebuild,v 1.2 2005/10/24 13:46:22 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="Swiss-army knive for reading and writing XML files"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Util-1.1.1-r1"
