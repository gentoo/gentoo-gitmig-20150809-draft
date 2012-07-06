# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/awk/awk-0.ebuild,v 1.3 2012/07/06 02:49:22 ottxor Exp $

DESCRIPTION="Virtual for awk implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh
~sparc ~sparc-fbsd ~x86 ~x86-fbsd ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		sys-apps/gawk
		sys-apps/mawk
		sys-apps/nawk
		sys-apps/busybox
	)"
