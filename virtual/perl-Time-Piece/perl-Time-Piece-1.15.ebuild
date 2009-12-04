# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Time-Piece/perl-Time-Piece-1.15.ebuild,v 1.3 2009/12/04 12:42:58 fauli Exp $

DESCRIPTION="Object Oriented time objects"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~sparc-fbsd"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Time-Piece-${PV} )"
