# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt/aspell-pt-0.50.2-r1.ebuild,v 1.1 2009/01/04 01:12:40 robbat2 Exp $

ASPELL_LANG="Portuguese"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

src_install() {
	aspell-dict_src_install
	rm "${D}"/usr/lib/aspell-0.60/pt_BR*
	rm "${D}"/usr/lib/aspell-0.60/brazilian.alias
}
