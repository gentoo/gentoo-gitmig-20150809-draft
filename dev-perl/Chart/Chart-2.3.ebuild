# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-2.3.ebuild,v 1.19 2007/01/14 22:41:17 mcummings Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl Chart Module"
SRC_URI="mirror://cpan/authors/id/C/CH/CHARTGRP/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chartgrp/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/GD-1.2
	dev-lang/perl"

SRC_TEST="do"

mydoc="TODO"
