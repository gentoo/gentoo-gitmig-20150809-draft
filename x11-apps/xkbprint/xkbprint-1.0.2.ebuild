# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbprint/xkbprint-1.0.2.ebuild,v 1.3 2009/12/10 18:42:04 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="print an XKB keyboard description"
KEYWORDS="amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libxkbfile"
DEPEND="${RDEPEND}"
