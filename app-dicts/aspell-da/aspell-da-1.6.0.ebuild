# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.6.0.ebuild,v 1.6 2010/10/07 23:27:15 leio Exp $

ASPELL_LANG="Danish"

inherit aspell-dict

LICENSE="GPL-2"
HOMEPAGE="http://da.speling.org"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

SRC_URI="http://da.speling.org/filer/new_${P}.tar.gz"
S=${WORKDIR}/new_${P}
