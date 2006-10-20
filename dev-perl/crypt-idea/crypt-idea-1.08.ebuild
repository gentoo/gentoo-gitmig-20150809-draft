# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-idea/crypt-idea-1.08.ebuild,v 1.8 2006/10/20 20:15:52 kloeri Exp $

inherit perl-module

MY_P=Crypt-IDEA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Parse and save PGP packet streams"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/D/DP/DPARIS/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DP/DPARIS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
