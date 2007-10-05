# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Color/PEAR-Image_Color-1.0.2.ebuild,v 1.12 2007/10/05 16:11:07 armin76 Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Manages and handles color data and conversions."

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

pkg_setup() {
	require_gd
}
