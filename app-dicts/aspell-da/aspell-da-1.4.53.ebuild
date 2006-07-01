# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.4.53.ebuild,v 1.2 2006/07/01 16:13:07 dragonheart Exp $

ASPELL_LANG="Danish"
inherit aspell-dict

HOMEPAGE="http://da.speling.org"
SRC_URI="http://da.speling.org/filer/new_${P}.tar.gz"
S=${WORKDIR}/new_${P}

LICENSE="GPL-2"
