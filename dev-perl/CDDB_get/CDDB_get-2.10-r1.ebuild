# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB_get/CDDB_get-2.10-r1.ebuild,v 1.6 2002/07/31 04:40:32 cselkirk Exp $

inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://armin.emx.at/cddb/"

SLOT="2"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"
