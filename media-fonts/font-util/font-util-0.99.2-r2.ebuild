# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-util/font-util-0.99.2-r2.ebuild,v 1.1 2005/12/08 22:58:37 spyderous Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-mapdir=/usr/share/fonts/util"

PATCHES="${FILESDIR}/configurable-mapdir.patch"
