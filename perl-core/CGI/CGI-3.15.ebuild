# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-3.15.ebuild,v 1.4 2006/02/27 15:15:55 corsair Exp $

inherit perl-module

myconf="INSTALLDIRS=vendor"
MY_P=${PN}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Common Gateway Interface Class"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/L/LD/LDS/CGI.pm-${PV}/"
IUSE=""
SLOT="0"
SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 mips ~ppc ppc64 sparc x86"
DEPEND=">=dev-lang/perl-5.8.0-r12"
