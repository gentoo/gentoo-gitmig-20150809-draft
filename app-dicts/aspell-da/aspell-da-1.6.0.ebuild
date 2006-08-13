# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.6.0.ebuild,v 1.1 2006/08/13 15:44:06 arj Exp $

ASPELL_LANG="Danish"
inherit aspell-dict

HOMEPAGE="http://da.speling.org"
SRC_URI="http://da.speling.org/filer/new_${P}.tar.gz"
S=${WORKDIR}/new_${P}

LICENSE="GPL-2"
