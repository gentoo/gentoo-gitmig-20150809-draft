# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Amazon/PEAR-Services_Amazon-0.3.1.ebuild,v 1.1 2005/10/10 13:35:09 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="Provides access to Amazon's retail and associate web services."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-HTTP_Request-1.2.4-r1
	>=dev-php/PEAR-XML_Serializer-0.15.0-r1"
