# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PhpDocumentor/PEAR-PhpDocumentor-1.4.0.ebuild,v 1.1 2007/08/18 15:52:24 hoffie Exp $

inherit php-pear-r1

DESCRIPTION="The phpDocumentor package provides automatic documenting of php api directly from the source."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-XML_Beautifier-1.1-r1 )"
