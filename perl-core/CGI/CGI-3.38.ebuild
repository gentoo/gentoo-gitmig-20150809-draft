# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-3.38.ebuild,v 1.1 2008/07/22 07:38:41 tove Exp $

MODULE_AUTHOR=LDS
inherit perl-module

MY_P=${PN}.pm-${PV}
DESCRIPTION="Simple Common Gateway Interface Class"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${MY_P}

SRC_TEST="do"
myconf="INSTALLDIRS=vendor"
