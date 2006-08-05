# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-be/aspell-be-0.01-r1.ebuild,v 1.1 2006/08/05 18:28:50 kloeri Exp $

ASPELL_LANG="Belarusian"
inherit aspell-dict

HOMEPAGE="http://www.aspell.net"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/be/aspell5-be-${PV}.tar.bz2"
IUSE="classic"

S="${WORKDIR}/aspell5-be-${PV}"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	use classic || epatch ${FILESDIR}/aspell5-be-${PV}-official.patch
}
