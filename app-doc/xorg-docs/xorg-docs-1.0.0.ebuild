# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xorg-docs/xorg-docs-1.0.0.ebuild,v 1.4 2005/12/20 02:12:57 geoman Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org docs"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}"

IUSE="doc"

PATCHES="${FILESDIR}/allow_manpages_only.patch"

CONFIGURE_OPTIONS="$(use_enable doc non-man-docs)"
