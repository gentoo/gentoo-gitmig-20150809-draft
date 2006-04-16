# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXvMC/libXvMC-1.0.1-r1.ebuild,v 1.2 2006/04/16 14:00:19 flameeyes Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XvMC library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-proto/videoproto
	x11-proto/xproto"
DEPEND="${RDEPEND}
	x11-proto/xextproto"
PATCHES="${FILESDIR}/${PV}-xvmc-xconfigdir.patch"
