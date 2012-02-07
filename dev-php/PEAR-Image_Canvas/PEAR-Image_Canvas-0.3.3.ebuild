# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Canvas/PEAR-Image_Canvas-0.3.3.ebuild,v 1.6 2012/02/07 16:30:51 jer Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides a common interface to image drawing, making image source code independent on the library used."

# see http://pear.php.net/bugs/bug.php?id=9699 wrt LICENSE
LICENSE="PHP-2.02 || ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Image_Color-1.0.0"

pkg_setup() {
	require_gd
}
