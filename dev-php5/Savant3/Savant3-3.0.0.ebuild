# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/Savant3/Savant3-3.0.0.ebuild,v 1.1 2007/08/30 12:51:28 jokey Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="The simple PHP template alternative to Smarty."
HOMEPAGE="http://phpsavant.com/yawiki/index.php?area=Savant3"
SRC_URI="http://phpsavant.com/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="form-plugin"

DEPEND=""
RDEPEND="form-plugin? ( >=dev-php5/Savant3-Plugin-Form-0.2.1 )"

need_php_by_category
