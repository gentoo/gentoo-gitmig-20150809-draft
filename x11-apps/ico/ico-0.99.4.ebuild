# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ico/ico-0.99.4.ebuild,v 1.1 2005/12/04 21:44:20 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org ico application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
RDEPEND=">=x11-libs/libX11-0.99.1_pre0"
DEPEND="${RDEPEND}"
