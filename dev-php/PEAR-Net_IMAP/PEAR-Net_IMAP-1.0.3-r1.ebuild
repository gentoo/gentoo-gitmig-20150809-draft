# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_IMAP/PEAR-Net_IMAP-1.0.3-r1.ebuild,v 1.3 2005/09/18 00:05:15 weeve Exp $

inherit php-pear-r1

DESCRIPTION="Provides an implementation of the IMAP protocol."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND} dev-php/PEAR-Net_Socket"
