# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-SOAP/PEAR-SOAP-0.8.1.ebuild,v 1.6 2005/03/27 15:50:00 kloeri Exp $

inherit php-pear

DESCRIPTION="SOAP Client/Server for PHP 4."
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~hppa amd64 ~ppc64"
IUSE=""
RDEPEND="dev-php/PEAR-HTTP_Request
		dev-php/PEAR-Mail_Mime
		dev-php/PEAR-Net_URL
		dev-php/PEAR-Net_DIME"
