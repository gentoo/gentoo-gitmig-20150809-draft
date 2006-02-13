# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-0.21.ebuild,v 1.6 2006/02/13 13:00:11 mcummings Exp $

inherit perl-module

DESCRIPTION="Remove files and directories"
SRC_URI="mirror://cpan/authors/id/R/RS/RSOD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rsod/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc ppc64"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-File-Spec-0.84"
