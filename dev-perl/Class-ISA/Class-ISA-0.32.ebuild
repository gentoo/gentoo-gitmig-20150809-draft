# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-ISA/Class-ISA-0.32.ebuild,v 1.3 2004/02/20 21:53:40 vapier Exp $

inherit perl-module

DESCRIPTION="Report the search path for a class's ISA tree"
HOMEPAGE="http://search.cpan.org/author/SBURKE/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa amd64"

DEPEND="dev-perl/Test-Simple
	dev-perl/Class-ISA
	dev-perl/File-Spec"
