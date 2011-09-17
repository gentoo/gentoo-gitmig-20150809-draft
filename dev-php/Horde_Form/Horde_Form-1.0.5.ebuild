# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Form/Horde_Form-1.0.5.ebuild,v 1.1 2011/09/17 12:09:49 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Form API"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Core-1*
	=dev-php/Horde_Date-1*
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Mime-1*
	=dev-php/Horde_Nls-1*
	=dev-php/Horde_Token-1*
	=dev-php/Horde_Translation-1*
	=dev-php/Horde_Util-1*"
RDEPEND="${DEPEND}"
