# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Sieve/PEAR-Net_Sieve-1.2.0_beta1.ebuild,v 1.1 2010/02/16 04:53:06 beandog Exp $

inherit php-pear-r1

DESCRIPTION="Provides an API to talk to the timsieved server that comes with Cyrus IMAPd"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="sasl"

RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.6-r1
	sasl? ( dev-php/PEAR-Auth_SASL )"
