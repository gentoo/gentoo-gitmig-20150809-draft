# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/PodParser/PodParser-1.34.ebuild,v 1.8 2006/08/18 02:19:32 mcummings Exp $

inherit perl-module
MY_P=Pod-Parser-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Base class for creating POD filters and translators"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MA/MAREKR/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
