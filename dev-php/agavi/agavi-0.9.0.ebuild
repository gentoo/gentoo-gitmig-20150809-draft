# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/agavi/agavi-0.9.0.ebuild,v 1.3 2006/01/01 16:51:02 sebastian Exp $

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
