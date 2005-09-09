# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Weather/PEAR-Services_Weather-1.3.2-r1.ebuild,v 1.2 2005/09/09 14:21:31 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="This class acts as an interface to various online weather-services.."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/PEAR-Cache-1.5.3
	>=dev-php/PEAR-DB-1.4
	>=dev-php/PEAR-HTTP_Request-1.2
	>=dev-php/PEAR-SOAP-0.7.5
	>=dev-php/PEAR-XML_Serializer-0.8"
