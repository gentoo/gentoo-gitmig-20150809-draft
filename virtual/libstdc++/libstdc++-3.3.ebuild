# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libstdc++/libstdc++-3.3.ebuild,v 1.17 2011/11/05 16:58:32 vapier Exp $

DESCRIPTION="Virtual for the GNU Standard C++ Library for <gcc-3.4"

SLOT="3.3"
KEYWORDS="amd64 arm ia64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"

DEPEND=""
RDEPEND="|| ( =sys-libs/libstdc++-v3-bin-3.3* =sys-libs/libstdc++-v3-3.3* )"
