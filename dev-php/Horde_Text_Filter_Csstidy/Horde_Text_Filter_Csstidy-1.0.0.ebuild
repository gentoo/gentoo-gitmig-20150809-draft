# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Text_Filter_Csstidy/Horde_Text_Filter_Csstidy-1.0.0.ebuild,v 1.1 2011/06/04 19:58:39 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Text Filter API"
LICENSE="GPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/${P}.tgz"

DEPEND="dev-lang/php[ctype]
	>=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Text_Filter-1*"
RDEPEND="${DEPEND}"
