# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Text/PEAR-Image_Text-0.6.0_beta.ebuild,v 1.3 2010/08/10 13:27:14 fauli Exp $

PEAR_PV="${PV/_/}"
inherit php-pear-r1 depend.php

DESCRIPTION="Advanced text manipulations in images."
LICENSE="PHP-3"
SLOT="0"

KEYWORDS="~amd64 x86"
IUSE=""

pkg_setup() {
	require_gd
}
