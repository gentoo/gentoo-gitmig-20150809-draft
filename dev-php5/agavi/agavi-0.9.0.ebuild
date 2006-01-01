# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/agavi/agavi-0.9.0.ebuild,v 1.1 2006/01/01 17:07:01 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="PHP5 MVC Application Framework"
HOMEPAGE="http://www.agavi.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://agavi.org/packages/agavi-${PV}.tgz"
RDEPEND="dev-php5/phing"

need_php5
