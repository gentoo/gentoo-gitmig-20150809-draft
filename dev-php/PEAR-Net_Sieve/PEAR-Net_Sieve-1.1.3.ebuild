# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Sieve/PEAR-Net_Sieve-1.1.3.ebuild,v 1.1 2006/07/02 12:01:52 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="Provides an API to talk to the timsieved server that comes with Cyrus IMAPd"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.6-r1"
