# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.13.ebuild,v 1.4 2004/05/24 00:44:45 kloeri Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Recursively copy Perl datatypes"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ~ppc ~sparc"

DEPEND=""

