# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-it/aspell-it-2.2.20050523.ebuild,v 1.1 2006/05/14 14:11:09 arj Exp $

inherit aspell-dict

ASPELL_LANG="Italian"
LICENSE="GPL-2"

ASPOSTFIX="6"

FILENAME="aspell6-it-2.2_20050523-0"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/it/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
