# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-1.23-r1.ebuild,v 1.5 2005/03/18 21:38:18 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"
HOMEPAGE="http://search.cpan.org/~kane/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KA/KANE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/IO-Zlib
	dev-perl/IO-String
	>=dev-perl/Test-Harness-2.26"
