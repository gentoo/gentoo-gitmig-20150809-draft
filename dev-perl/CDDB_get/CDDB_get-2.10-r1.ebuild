# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB_get/CDDB_get-2.10-r1.ebuild,v 1.1 2002/05/05 14:08:57 seemant Exp $

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
HOMEPAGE="http://armin.emx.at/cddb/"

SLOT="2"
