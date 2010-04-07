# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xset/xset-1.1.0.ebuild,v 1.11 2010/04/07 22:35:46 chithanh Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xset application"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libXmu
	x11-libs/libXfontcache
	x11-libs/libXxf86misc"
DEPEND="${RDEPEND}"
