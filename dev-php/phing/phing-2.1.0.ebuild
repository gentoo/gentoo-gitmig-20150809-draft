# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phing/phing-2.1.0.ebuild,v 1.4 2005/10/12 11:10:08 humpback Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="PHP project build system based on Apache Ant."
HOMEPAGE="http://www.phing.info/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://phing.info/pear/phing-${PV}-pear.tgz"

need_php5
