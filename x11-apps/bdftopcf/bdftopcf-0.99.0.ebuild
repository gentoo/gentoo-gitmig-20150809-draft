# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/bdftopcf/bdftopcf-0.99.0.ebuild,v 1.5 2005/08/23 00:29:06 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org bdftopcf application"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXfont"
DEPEND="${RDEPEND}"
