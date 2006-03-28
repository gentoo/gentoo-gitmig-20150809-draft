# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-0.31.ebuild,v 1.6 2006/03/28 22:56:11 agriffis Exp $

inherit perl-module

DESCRIPTION="Remove files and directories"
SRC_URI="mirror://cpan/authors/id/R/RS/RSOD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rsod/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-File-Spec-0.84"
