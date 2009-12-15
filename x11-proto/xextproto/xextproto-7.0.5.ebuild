# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xextproto/xextproto-7.0.5.ebuild,v 1.8 2009/12/15 19:49:39 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XExt protocol headers"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-proto/inputproto"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PV}-dont-pull-in-Xmd-h-in-Xge-h.patch" )
