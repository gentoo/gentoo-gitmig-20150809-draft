# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xman/xman-1.0.2.ebuild,v 1.5 2006/09/10 09:06:03 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xman application"

KEYWORDS="~amd64 ~arm ~mips ~ppc ppc64 s390 ~sparc x86"
IUSE="xprint"

RDEPEND="xprint? ( x11-libs/libXprintUtil )"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"
