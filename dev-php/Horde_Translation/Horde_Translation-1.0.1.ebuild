# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Translation/Horde_Translation-1.0.1.ebuild,v 1.2 2012/02/02 14:46:17 ssuominen Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
DESCRIPTION="Horde translation library"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0"
RDEPEND="${DEPEND}
	=dev-php/Horde_Exception-1*"
