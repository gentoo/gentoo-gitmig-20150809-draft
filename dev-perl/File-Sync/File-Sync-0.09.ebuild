# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Sync/File-Sync-0.09.ebuild,v 1.13 2006/09/01 14:07:51 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl access to fsync() and sync() function calls"
HOMEPAGE="http://search.cpan.org/~cevans/${P}/"
SRC_URI="mirror://cpan/authors/id/C/CE/CEVANS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
