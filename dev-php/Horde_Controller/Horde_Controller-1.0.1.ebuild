# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Controller/Horde_Controller-1.0.1.ebuild,v 1.1 2011/09/17 10:53:23 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Controller libraries"
LICENSE="BSD"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Injector-1*
	=dev-php/Horde_Log-1*
	=dev-php/Horde_Support-1*
	=dev-php/Horde_Util-1*"
RDEPEND="${DEPEND}"
