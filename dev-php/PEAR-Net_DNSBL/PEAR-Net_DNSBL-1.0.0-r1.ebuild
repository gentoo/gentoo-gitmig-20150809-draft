# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNSBL/PEAR-Net_DNSBL-1.0.0-r1.ebuild,v 1.3 2005/09/11 19:54:46 weeve Exp $

inherit php-pear-r1

DESCRIPTION="DNSBL Checker"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php/PEAR-Cache_Lite-1.3.1
	>=dev-php/PEAR-Net_CheckIP-1.1
	>=dev-php/PEAR-HTTP_Request-1.2.3"
