# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Tester/Test-Tester-0.103.ebuild,v 1.8 2006/10/20 20:09:30 kloeri Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Perl module for Apache::Session"
SRC_URI="mirror://cpan/authors/id/F/FD/FDALY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~fdaly/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc ~x86"

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
