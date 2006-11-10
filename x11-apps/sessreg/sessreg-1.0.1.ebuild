# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/sessreg/sessreg-1.0.1.ebuild,v 1.1 2006/11/10 03:55:08 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="manage utmp/wtmp entries for non-init clients"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"

PATCHES="${FILESDIR}/${PV}-fix_grep_regex.patch"
