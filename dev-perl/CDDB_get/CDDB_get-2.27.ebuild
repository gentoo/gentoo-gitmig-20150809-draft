# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB_get/CDDB_get-2.27.ebuild,v 1.6 2006/03/28 22:36:09 agriffis Exp $

inherit perl-module

DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
HOMEPAGE="http://armin.emx.at/cddb/"

SLOT="2"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
