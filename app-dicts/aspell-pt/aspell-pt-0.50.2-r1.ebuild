# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt/aspell-pt-0.50.2-r1.ebuild,v 1.9 2010/05/30 17:29:40 armin76 Exp $

ASPELL_LANG="Portuguese"

inherit multilib aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

src_install() {
	aspell-dict_src_install
	rm "${D}"/usr/$(get_libdir)/aspell-0.60/pt_BR*
	rm "${D}"/usr/$(get_libdir)/aspell-0.60/brazilian.alias
}
