# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.01.ebuild,v 1.2 2003/05/31 21:14:25 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
