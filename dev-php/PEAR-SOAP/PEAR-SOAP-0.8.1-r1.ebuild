# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-SOAP/PEAR-SOAP-0.8.1-r1.ebuild,v 1.2 2005/09/09 14:21:31 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="SOAP Client/Server for PHP 4"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="${RDEPEND}
	dev-php/PEAR-HTTP_Request
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-Net_URL
	dev-php/PEAR-Net_DIME"
