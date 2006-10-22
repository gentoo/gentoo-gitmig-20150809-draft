# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdbedizzy/xdbedizzy-1.0.2.ebuild,v 1.1 2006/10/22 17:55:49 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xdbedizzy application"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

# xprint support isn't optional, despite what configure says.
#IUSE="xprint"
RDEPEND="x11-libs/libXext
	x11-libs/libXprintUtil
	x11-libs/libXp"
#	xprint? ( x11-libs/libXprintUtil
#		x11-libs/libXp )"
DEPEND="${RDEPEND}"

#CONFIGURE_OPTIONS="$(use_enable xprint)"
