# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Amazon/PEAR-Services_Amazon-0.4.0.ebuild,v 1.2 2005/10/24 13:46:22 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="Provides access to Amazon's retail and associate web services."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-HTTP_Request-1.2.4-r1
	>=dev-php/PEAR-XML_Serializer-0.15.0-r1"
