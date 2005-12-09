# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gccmakedep/gccmakedep-0.99.0.ebuild,v 1.1 2005/12/09 21:38:24 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org gccmakedep utility"
KEYWORDS="~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"

# Until it hits the fd.o mirrors, this is where it is.
SRC_URI="http://people.freedesktop.org/~ajax/${P}.tar.gz"
