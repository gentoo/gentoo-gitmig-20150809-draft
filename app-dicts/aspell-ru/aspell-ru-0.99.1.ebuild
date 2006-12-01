# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-ru/aspell-ru-0.99.1.ebuild,v 1.6 2006/12/01 01:43:50 kevquinn Exp $

ASPELL_LANG="Russian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

# very strange filename not supported by the gentoo naming scheme
FILENAME=aspell6-ru-0.99f7-1

SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/ru/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
