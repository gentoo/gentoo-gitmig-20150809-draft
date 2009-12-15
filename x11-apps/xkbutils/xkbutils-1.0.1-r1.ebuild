# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbutils/xkbutils-1.0.1-r1.ebuild,v 1.12 2009/12/15 16:38:57 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbutils application"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libxkbfile
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-proto/inputproto"

CONFIGURE_OPTIONS="--disable-xprint"
