# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-ru/aspell-ru-0.99.1.ebuild,v 1.3 2004/12/18 19:23:36 blubb Exp $

ASPELL_LANG="Russian"

LICENSE="GPL-2"

ASPOSTFIX="6"

inherit aspell-dict

# as this depends on aspell 0.6 we need to change the KEYWORDS
KEYWORDS="~amd64 ~sparc ~x86"

# very strange filename not supported by the gentoo naming scheme
FILENAME=aspell6-ru-0.99f7-1

SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/ru/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
IUSE=""
