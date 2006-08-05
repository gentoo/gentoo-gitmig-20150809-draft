# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LockFile-Simple/LockFile-Simple-0.2.5-r1.ebuild,v 1.14 2006/08/05 13:34:24 mcummings Exp $

inherit perl-module

DESCRIPTION="File locking module for Perl"
SRC_URI="mirror://cpan/authors/id/R/RA/RAM/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/LockFile/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 s390 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
