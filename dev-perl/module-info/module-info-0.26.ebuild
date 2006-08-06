# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.26.ebuild,v 1.11 2006/08/06 02:53:26 mcummings Exp $

inherit perl-module

MY_P="Module-Info-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Information about Perl modules"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MB/MBARBON/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MB/MBARBON/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa mips ppc sparc x86 ppc64"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
