# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt-br/aspell-pt-br-6.0.20070411.ebuild,v 1.4 2007/08/25 20:34:37 armin76 Exp $

ASPELL_LANG="Brazilian Portuguese"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~sparc ~x86"

FILENAME="aspell6-pt_BR-20070411-0"
SRC_URI="mirror://gnu/aspell/dict/pt_BR/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
