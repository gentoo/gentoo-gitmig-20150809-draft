# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/agavi/agavi-0.10.1b.ebuild,v 1.2 2007/03/17 22:44:49 chtekk Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP5 MVC Application Framework."
HOMEPAGE="http://www.agavi.org/"
SRC_URI="http://agavi.org/packages/agavi-${PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-php5/phing"

need_php_by_category
