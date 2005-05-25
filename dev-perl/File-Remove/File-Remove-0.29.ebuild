# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-0.29.ebuild,v 1.2 2005/05/25 13:40:50 mcummings Exp $

inherit perl-module

DESCRIPTION="Remove files and directories"
SRC_URI="mirror://cpan/authors/id/R/RS/RSOD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rsod/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc ~ppc64"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/File-Spec-0.84"
