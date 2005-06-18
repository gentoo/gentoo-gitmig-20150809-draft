# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-SOAP/PEAR-SOAP-0.8.1.ebuild,v 1.11 2005/06/18 10:42:46 hansmi Exp $

inherit php-pear

DESCRIPTION="SOAP Client/Server for PHP 4"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="dev-php/PEAR-HTTP_Request
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-Net_URL
	dev-php/PEAR-Net_DIME"
