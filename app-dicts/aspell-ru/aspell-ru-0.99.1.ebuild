# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-ru/aspell-ru-0.99.1.ebuild,v 1.5 2005/02/20 10:21:10 arj Exp $

ASPELL_LANG="Russian"

LICENSE="GPL-2"

ASPOSTFIX="6"

inherit aspell-dict

# very strange filename not supported by the gentoo naming scheme
FILENAME=aspell6-ru-0.99f7-1

SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/ru/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
