# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt-br/aspell-pt-br-6.0.20090702.ebuild,v 1.7 2010/06/05 15:38:52 armin76 Exp $

ASPELL_LANG="Brazilian Portuguese"
ASPOSTFIX=6

inherit aspell-dict

FILENAME=aspell6-pt_BR-20090702-0
SRC_URI="mirror://gnu/aspell/dict/pt_BR/${FILENAME}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${FILENAME}

# Contains a conflict
RDEPEND="!<app-dicts/aspell-pt-0.50.2-r1"
