# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flat/File-Flat-0.94.ebuild,v 1.8 2006/07/04 08:37:31 ian Exp $

inherit perl-module

DESCRIPTION="Implements a flat filesystem"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/Class-Autouse-1
	dev-perl/module-build
	dev-perl/File-Remove
	virtual/perl-File-Spec
	>=virtual/perl-File-Temp-0.14
	dev-perl/File-NCopy
	>=dev-perl/File-Remove-0.21
	dev-perl/Test-ClassAPI
	dev-perl/File-Slurp
	dev-perl/Class-Inspector"
RDEPEND="${DEPEND}"