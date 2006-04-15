# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xhost/xhost-1.0.1.ebuild,v 1.1 2006/04/15 06:30:14 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xhost application"
RESTRICT="mirror"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
