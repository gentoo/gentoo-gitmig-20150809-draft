# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/PodParser/PodParser-1.30.ebuild,v 1.3 2005/12/31 13:47:37 corsair Exp $

inherit perl-module
MY_P=Pod-Parser-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Print Usage messages based on your own pod"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MA/MAREKR/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
