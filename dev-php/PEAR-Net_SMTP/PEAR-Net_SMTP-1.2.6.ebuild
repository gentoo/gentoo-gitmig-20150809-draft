# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_SMTP/PEAR-Net_SMTP-1.2.6.ebuild,v 1.11 2005/06/18 10:39:45 hansmi Exp $

inherit php-pear

DESCRIPTION="Tar file management class"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="dev-php/PEAR-Auth_SASL
	dev-php/PEAR-Net_Socket"
