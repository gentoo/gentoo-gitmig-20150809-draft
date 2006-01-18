# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-0.30.ebuild,v 1.4 2006/01/18 09:14:12 gmsoft Exp $

inherit perl-module

DESCRIPTION="Remove files and directories"
SRC_URI="mirror://cpan/authors/id/R/RS/RSOD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rsod/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/File-Spec-0.84"
