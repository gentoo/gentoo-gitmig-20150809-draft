# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/math-pari/math-pari-2.010704.ebuild,v 1.7 2006/10/20 17:06:50 mcummings Exp $

inherit perl-module eutils

MY_P="Math-Pari-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to PARI"
HOMEPAGE="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/I/IL/ILYAZ/modules/${MY_P}.tar.gz
		http://pari.math.u-bordeaux.fr/pub/pari/unix/pari-2.1.7.tgz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~mips ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

# Math::Pari requires that a copy of the pari source in a parallel
# directory to where you build it. It does not need to compile it, but
# it does need to be the same version as is installed, hence the hard
# DEPEND below
DEPEND="~sci-mathematics/pari-2.1.7
	dev-lang/perl"

