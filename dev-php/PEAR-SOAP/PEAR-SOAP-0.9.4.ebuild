# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-SOAP/PEAR-SOAP-0.9.4.ebuild,v 1.2 2007/02/11 10:58:23 vapier Exp $

inherit php-pear-r1

DESCRIPTION="SOAP Client/Server for PHP 4"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-HTTP_Request-1.2.4-r1
	dev-php/PEAR-Mail
	>=dev-php/PEAR-Mail_Mime-1.3.1-r1
	>=dev-php/PEAR-Net_URL-1.0.14-r1
	>=dev-php/PEAR-Net_DIME-0.3-r1"
