# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-1.23.ebuild,v 1.3 2005/01/21 19:21:03 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"
HOMEPAGE="http://search.cpan.org/~kane/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KA/KANE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc x86 ~ppc64"
IUSE=""

DEPEND="dev-perl/IO-Zlib
	>=dev-perl/Test-Harness-2.26"
