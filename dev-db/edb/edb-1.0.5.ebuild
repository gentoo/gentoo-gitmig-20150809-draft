# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.5.ebuild,v 1.4 2004/10/22 01:59:07 vapier Exp $

ECVS_MODULE="e17/libs/edb"
EHACKAUTOGEN=yes
inherit enlightenment flag-o-matic

DESCRIPTION="Enlightenment Data Base"
HOMEPAGE="http://www.enlightenment.org/pages/edb.html"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64 ppc64"
IUSE="gtk ncurses"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="virtual/libc"

src_compile() {
	export MY_ECONF="
		--enable-compat185
		--enable-dump185
	"
	use ppc && filter-lfs-flags
	enlightenment_src_compile
}
