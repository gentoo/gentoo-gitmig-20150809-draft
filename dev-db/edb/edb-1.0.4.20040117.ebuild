# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.4.20040117.ebuild,v 1.1 2004/01/20 02:07:01 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment flag-o-matic

DESCRIPTION="Enlightment Data Base"
HOMEPAGE="http://www.enlightenment.org/pages/edb.html"

IUSE="${IUSE} ncurses gtk"

DEPEND="${DEPEND}
	gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="virtual/glibc"

src_compile() {
	export MY_ECONF="
		--enable-compat185
		--enable-dump185
	"
	enlightenment_src_compile
}
