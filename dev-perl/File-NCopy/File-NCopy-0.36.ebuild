# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-NCopy/File-NCopy-0.36.ebuild,v 1.3 2009/07/02 19:33:42 jer Exp $

inherit perl-module

DESCRIPTION="Copy file, file Copy file[s] | dir[s], dir"
SRC_URI="mirror://cpan/authors/id/C/CH/CHORNY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mzsanford/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="virtual/perl-File-Spec
	dev-lang/perl"
