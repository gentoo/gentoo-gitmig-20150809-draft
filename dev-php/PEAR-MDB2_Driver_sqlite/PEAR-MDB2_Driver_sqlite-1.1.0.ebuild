# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_sqlite/PEAR-MDB2_Driver_sqlite-1.1.0.ebuild,v 1.1 2006/07/19 12:11:11 chtekk Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Database Abstraction Layer, sqlite driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-php/PEAR-MDB2"
RDEPEND="${DEPEND}"

pkg_setup() {
	has_php
	require_sqlite
}
