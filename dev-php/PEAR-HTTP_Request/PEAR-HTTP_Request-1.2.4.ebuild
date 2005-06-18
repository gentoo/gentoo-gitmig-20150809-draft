# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Request/PEAR-HTTP_Request-1.2.4.ebuild,v 1.11 2005/06/18 10:41:56 hansmi Exp $

inherit php-pear

DESCRIPTION="Provides an easy way to perform HTTP requests"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_URL-1.0.12
	>=dev-php/PEAR-Net_Socket-1.0.2"
