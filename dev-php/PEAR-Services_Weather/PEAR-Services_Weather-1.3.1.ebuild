# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Weather/PEAR-Services_Weather-1.3.1.ebuild,v 1.11 2005/06/18 10:43:52 hansmi Exp $

inherit php-pear

DESCRIPTION="This class acts as an interface to various online weather-services.."

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Cache-1.5.3
	>=dev-php/PEAR-DB-1.4
	>=dev-php/PEAR-HTTP_Request-1.2
	>=dev-php/PEAR-SOAP-0.7.5
	>=dev-php/PEAR-XML_Serializer-0.8"
