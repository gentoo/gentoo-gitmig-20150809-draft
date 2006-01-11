# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.64.ebuild,v 1.1 2006/01/11 10:37:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"
HOMEPAGE="http://search.cpan.org/~dsugal/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DS/DSUGAL/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

