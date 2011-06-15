# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Template/Horde_Template-1.0.0.ebuild,v 1.2 2011/06/15 17:07:23 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Template System"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0"
RDEPEND="${DEPEND}"
