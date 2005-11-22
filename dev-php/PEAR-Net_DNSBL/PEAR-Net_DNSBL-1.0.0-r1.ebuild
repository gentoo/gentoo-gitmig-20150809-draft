# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNSBL/PEAR-Net_DNSBL-1.0.0-r1.ebuild,v 1.7 2005/11/22 18:46:26 corsair Exp $

inherit php-pear-r1

DESCRIPTION="DNSBL Checker"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Cache_Lite-1.5.2-r1
	>=dev-php/PEAR-Net_CheckIP-1.1-r1
	>=dev-php/PEAR-HTTP_Request-1.2.4-r1"
