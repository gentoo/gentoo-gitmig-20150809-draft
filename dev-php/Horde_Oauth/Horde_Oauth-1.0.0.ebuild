# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Oauth/Horde_Oauth-1.0.0.ebuild,v 1.1 2011/06/04 20:04:27 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde OAuth client/server"
LICENSE="BSD"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/${P}.tgz"

DEPEND="dev-lang/php[hash,ssl]
	>=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Http-1*"
RDEPEND="${DEPEND}"
