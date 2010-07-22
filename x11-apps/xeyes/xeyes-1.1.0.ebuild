# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xeyes/xeyes-1.1.0.ebuild,v 1.7 2010/07/22 15:55:18 maekke Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xeyes application"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXrender"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-xrender"
