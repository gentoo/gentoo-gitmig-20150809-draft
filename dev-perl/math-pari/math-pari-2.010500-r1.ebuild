# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/math-pari/math-pari-2.010500-r1.ebuild,v 1.14 2006/07/05 18:37:44 ian Exp $

inherit perl-module

MY_P="Math-Pari-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to PARI"
HOMEPAGE="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/I/IL/ILYAZ/modules/${MY_P}.tar.gz
		http://www.gn-50uma.de/ftp/pari-2.1/pari-2.1.5.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa amd64 ~mips"
IUSE=""

# Math::Pari requires that a copy of the pari source in a parallel
# directory to where you build it. It does not need to compile it, but
# it does need to be the same version as is installed, hence the hard
# DEPEND below
DEPEND="~sci-mathematics/pari-2.1.5"
RDEPEND="${DEPEND}"