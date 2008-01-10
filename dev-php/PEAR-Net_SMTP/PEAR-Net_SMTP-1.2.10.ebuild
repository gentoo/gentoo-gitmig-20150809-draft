# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_SMTP/PEAR-Net_SMTP-1.2.10.ebuild,v 1.10 2008/01/10 10:06:30 vapier Exp $

inherit php-pear-r1

DESCRIPTION="An implementation of the SMTP protocol"

LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="minimal"

RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.7
	!minimal? ( >=dev-php/PEAR-Auth_SASL-1.0.1-r1 )"
