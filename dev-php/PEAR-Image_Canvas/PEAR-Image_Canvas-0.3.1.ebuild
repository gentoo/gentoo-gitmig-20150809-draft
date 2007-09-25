# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Canvas/PEAR-Image_Canvas-0.3.1.ebuild,v 1.4 2007/09/25 00:35:22 pylon Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides a common interface to image drawing, making image source code independent on the library used."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Image_Color-1.0.0"

pkg_setup() {
	require_gd
}
