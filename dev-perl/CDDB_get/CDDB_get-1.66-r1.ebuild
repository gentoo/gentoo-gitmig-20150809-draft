# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB_get/CDDB_get-1.66-r1.ebuild,v 1.11 2003/02/13 10:57:45 vapier Exp $

inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://armin.emx.at/cddb/"

SLOT="1"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 sparc alpha"
