# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Request/PEAR-HTTP_Request-1.2.4.ebuild,v 1.3 2005/03/09 06:36:48 sebastian Exp $

inherit php-pear

DESCRIPTION="Provides an easy way to perform HTTP requests."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""
RDEPEND=">=dev-php/PEAR-Net_URL-1.0.12
		>=dev-php/PEAR-Net_Socket-1.0.2"
