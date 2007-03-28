# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tempdir/File-Tempdir-0.02.ebuild,v 1.3 2007/03/28 20:18:29 armin76 Exp $

inherit perl-module

DESCRIPTION="This module provide an object interface to tempdir() from File::Temp"
HOMEPAGE="http://search.cpan.org/~nanardon"
SRC_URI="mirror://cpan/authors/id/N/NA/NANARDON/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
