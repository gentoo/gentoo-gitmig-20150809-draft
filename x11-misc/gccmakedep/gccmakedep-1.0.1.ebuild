# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gccmakedep/gccmakedep-1.0.1.ebuild,v 1.3 2006/01/02 21:56:18 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org gccmakedep utility"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
