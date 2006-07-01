# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xorg-docs/xorg-docs-1.2.ebuild,v 1.5 2006/07/01 01:17:40 spyderous Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org docs"
KEYWORDS="alpha amd64 arm ~hppa ~ia64 mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"

IUSE="doc"

PATCHES="${FILESDIR}/1.1-allow_manpages_only.patch"

CONFIGURE_OPTIONS="$(use_enable doc non-man-docs)
	--with-x11docdir=/usr/share/doc/${PF}"
