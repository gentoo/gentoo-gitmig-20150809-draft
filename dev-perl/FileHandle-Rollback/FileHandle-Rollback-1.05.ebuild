# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FileHandle-Rollback/FileHandle-Rollback-1.05.ebuild,v 1.12 2006/08/05 04:00:02 mcummings Exp $

inherit perl-module

DESCRIPTION="FileHandle with commit and rollback"
SRC_URI="mirror://cpan/authors/id/M/MI/MIKO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~miko/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
