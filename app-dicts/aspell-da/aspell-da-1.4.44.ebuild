# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.4.44.ebuild,v 1.1 2004/10/28 22:00:10 arj Exp $

ASPELL_LANG="Danish"
inherit aspell-dict

HOMEPAGE="http://da.spelling.org"
SRC_URI="http://da.speling.org/filer/new_${P}.tar.gz"
S=${WORKDIR}/new_${P}

LICENSE="GPL-2"
