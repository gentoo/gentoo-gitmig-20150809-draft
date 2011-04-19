# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_W3C_HTMLValidator/PEAR-Services_W3C_HTMLValidator-1.0.0.ebuild,v 1.1 2011/04/19 13:44:59 olemarkus Exp $

inherit php-pear-r1

DESCRIPTION="Object oriented interface to the API of validator.w3.org."

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-HTTP_Request-1.3.0 )"

