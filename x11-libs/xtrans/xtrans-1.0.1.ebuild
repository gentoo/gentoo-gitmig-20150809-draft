# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xtrans/xtrans-1.0.1.ebuild,v 1.7 2006/07/19 09:09:17 gmsoft Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xtrans library"
RESTRICT="mirror"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"
