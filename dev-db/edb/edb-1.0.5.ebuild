# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.5.ebuild,v 1.9 2010/10/19 05:49:58 leio Exp $

ECVS_MODULE="e17/libs/edb"
inherit enlightenment flag-o-matic

DESCRIPTION="Enlightenment Data Base"
HOMEPAGE="http://www.enlightenment.org/Libraries/Edb/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="gtk ncurses"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	export MY_ECONF="
		--enable-compat185
		--enable-dump185
	"
	use ppc && filter-lfs-flags
	enlightenment_src_compile
}
