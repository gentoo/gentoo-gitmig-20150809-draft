# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-Piece/Time-Piece-1.13.ebuild,v 1.3 2009/12/16 22:00:31 abcd Exp $

MODULE_AUTHOR=MSERGEANT
inherit perl-module

DESCRIPTION="Object Oriented time objects"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 sparc x86 ~sparc-fbsd ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
