# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-it/aspell-it-2.4.20070901.ebuild,v 1.1 2012/04/19 16:56:24 pesa Exp $

ASPELL_LANG="Italian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=

MY_P=aspell${ASPOSTFIX}-${PN#aspell-}-${PV%.*}-${PV##*.}-0

SRC_URI="mirror://sourceforge/linguistico/${MY_P}.tar.bz2"
S=${WORKDIR}/${MY_P}
