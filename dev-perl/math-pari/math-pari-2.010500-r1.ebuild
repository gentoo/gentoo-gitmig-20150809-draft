# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/math-pari/math-pari-2.010500-r1.ebuild,v 1.2 2003/07/10 17:53:30 mcummings Exp $

inherit perl-module

MY_P="Math-Pari-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to PARI"
SRC_URI="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.tar.gz
		http://www.gn-50uma.de/ftp/pari-2.1/pari-2.1.5.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

# Math::Pari requires that a copy of the pari source in a parallel
# directory to where you build it. It does not need to compile it, but
# it does need to be the same version as is installed, hence the hard
# DEPEND below

DEPEND="=app-sci/pari-2.1.5"

