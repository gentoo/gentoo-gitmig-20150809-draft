# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lchown/Lchown-1.01.ebuild,v 1.2 2010/10/25 15:53:20 jlec Exp $

MODULE_AUTHOR="NCLEATON"
inherit perl-app

DESCRIPTION="Use the lchown(2) system call from Perl"
HOMEPAGE="http://search.cpan.org/~ncleaton/Lchown-1.01/lib/Lchown.pm"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build"
