# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB_get/CDDB_get-2.2.ebuild,v 1.2 2003/06/01 02:38:29 mcummings Exp $

inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
HOMEPAGE="http://armin.emx.at/cddb/"

SLOT="2"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
