# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xhost/xhost-1.0.2.ebuild,v 1.6 2007/09/08 04:22:49 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Controls host and/or user access to a running X server."

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND="x11-libs/libX11
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
