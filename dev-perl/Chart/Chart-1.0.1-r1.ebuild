# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-1.0.1-r1.ebuild,v 1.4 2003/02/13 10:59:06 vapier Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Chart Module"
SRC_URI="http://www.cpan.org/modules/by-module/Chart/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Chart/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/GD-1.19"


mydoc="TODO"
