# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-pear/horde-pear-1.3-r3.ebuild,v 1.7 2005/04/06 19:45:33 corsair Exp $

DESCRIPTION="Meta package for the PEAR packages required by Horde."
HOMEPAGE="http://pear.php.net/"

LICENSE="as-is"
SLOT="1"
# when unmasking for an arch
# double check none of the deps are still masked!
KEYWORDS="x86 ~ppc ~sparc alpha ~hppa amd64 ppc64"
IUSE=""

S=${WORKDIR}

RDEPEND="dev-php/PEAR-Log
	dev-php/PEAR-Mail_Mime
	>=dev-php/PEAR-DB-1.6.0
	dev-php/PEAR-File
	dev-php/PEAR-Date
	>=dev-php/PEAR-Services_Weather-1.3.1"
