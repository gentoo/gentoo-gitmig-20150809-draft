# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.13.ebuild,v 1.1 2003/06/04 11:11:27 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Recursively copy Perl datatypes"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

DEPEND=""

