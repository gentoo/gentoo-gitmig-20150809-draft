# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt-br/aspell-pt-br-6.0.20090702.ebuild,v 1.1 2009/12/05 19:08:40 ssuominen Exp $

ASPELL_LANG="Brazilian Portuguese"
ASPOSTFIX=6

inherit aspell-dict

FILENAME=aspell6-pt_BR-20090702-0
SRC_URI="mirror://gnu/aspell/dict/pt_BR/${FILENAME}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${FILENAME}

# Contains a conflict
RDEPEND="!<app-dicts/aspell-pt-0.50.2-r1"
