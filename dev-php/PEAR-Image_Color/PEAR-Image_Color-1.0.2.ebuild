# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Color/PEAR-Image_Color-1.0.2.ebuild,v 1.1 2006/01/28 07:08:00 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Manages and handles color data and conversions."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	require_gd
}
