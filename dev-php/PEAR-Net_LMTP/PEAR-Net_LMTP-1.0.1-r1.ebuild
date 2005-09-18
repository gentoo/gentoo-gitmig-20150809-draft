# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_LMTP/PEAR-Net_LMTP-1.0.1-r1.ebuild,v 1.3 2005/09/18 03:56:52 weeve Exp $

inherit php-pear-r1

DESCRIPTION="Provides an implementation of the RFC2033 LMTP protocol."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND} dev-php/PEAR-Net_Socket"
