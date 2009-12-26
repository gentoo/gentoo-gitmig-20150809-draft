# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-ro/aspell-ro-3.3.ebuild,v 1.1 2009/12/26 21:05:52 pva Exp $

ASPELL_LANG="Romanian"

inherit aspell-dict

HOMEPAGE="http://rospell.sourceforge.net/"

SRC_URI="mirror://sourceforge/rospell/aspell5-ro-${PV}.tar.bz2"

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"

S="${WORKDIR}/aspell5-ro-${PV}"
