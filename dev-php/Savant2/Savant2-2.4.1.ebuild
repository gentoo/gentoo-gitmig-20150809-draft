# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Savant2/Savant2-2.4.1.ebuild,v 1.1 2005/11/24 12:39:22 chtekk Exp $

inherit php-pear-lib-r1

DESCRIPTION="The simple PHP template alternative to Smarty."
HOMEPAGE="http://phpsavant.com/"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86"
IUSE=""
SRC_URI="http://phpsavant.com/${P}.tgz"

need_php_by_category
