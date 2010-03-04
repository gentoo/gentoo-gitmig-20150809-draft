# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-hu/aspell-hu-0.99.4.2.ebuild,v 1.5 2010/03/04 15:41:23 jer Exp $

ASPELL_LANG="Hungarian"
APOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~amd64 ~hppa ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

FILENAME="aspell6-hu-0.99.4.2-0"
SRC_URI="mirror://gnu/aspell/dict/hu/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"
