# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Request/PEAR-HTTP_Request-1.3.0.ebuild,v 1.12 2006/02/18 20:14:22 agriffis Exp $

inherit php-pear-r1

DESCRIPTION="Provides an easy way to perform HTTP requests"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_URL-1.0.14-r1
	>=dev-php/PEAR-Net_Socket-1.0.6-r1"
