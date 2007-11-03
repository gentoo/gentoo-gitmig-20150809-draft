# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt-br/aspell-pt-br-6.0.20070411.ebuild,v 1.7 2007/11/03 22:18:07 uberlord Exp $

ASPELL_LANG="Brazilian Portuguese"
ASPOSTFIX="6"

inherit aspell-dict

FILENAME="aspell6-pt_BR-20070411-0"
SRC_URI="mirror://gnu/aspell/dict/pt_BR/${FILENAME}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

S=${WORKDIR}/${FILENAME}
