# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Inspector/Class-Inspector-1.ebuild,v 1.2 2003/06/21 21:36:35 drobbins Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Provides information about Classes"
SRC_URI="http://search.cpan.org/CPAN/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/ADAMK/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Test-Simple
	dev-perl/Class-ISA
	dev-perl/File-Spec"
