# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.5.042.ebuild,v 1.1 2008/11/30 08:06:28 vapier Exp $

E_SNAP_DATE="2008-01-25"
inherit enlightenment flag-o-matic

DESCRIPTION="Enlightenment Data Base"
HOMEPAGE="http://www.enlightenment.org/Libraries/Edb/"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gtk ncurses"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	export MY_ECONF="
		--enable-compat185
		--enable-dump185
		$(use_enable gtk)
		$(use_enable ncurses)
	"
	use ppc && filter-lfs-flags
	enlightenment_src_compile
}
