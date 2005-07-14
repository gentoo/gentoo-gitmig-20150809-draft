# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phing/phing-2.1.0.ebuild,v 1.1 2005/07/14 04:40:38 sebastian Exp $

inherit php-pear

DESCRIPTION="PHP project build system based on Apache Ant."
HOMEPAGE="http://www.phing.info/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://phing.info/pear/phing-${PV}-pear.tgz"
RDEPEND=">=dev-php/php-5.0.0"
