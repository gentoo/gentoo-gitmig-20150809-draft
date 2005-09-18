# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_SMTP/PEAR-Net_SMTP-1.2.6-r1.ebuild,v 1.3 2005/09/18 04:24:09 weeve Exp $

inherit php-pear-r1

DESCRIPTION="Tar file management class"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	dev-php/PEAR-Auth_SASL
	dev-php/PEAR-Net_Socket"
