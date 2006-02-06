# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PatchReader/PatchReader-0.9.5.ebuild,v 1.9 2006/02/06 20:33:39 blubb Exp $

inherit perl-module

# this is a dependency for bugzilla

DESCRIPTION="Module for reading diff-compatible patch files"
SRC_URI="mirror://cpan/authors/id/J/JK/JKEISER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JK/JKEISER/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

DEPEND="perl-core/File-Temp"
IUSE=""
