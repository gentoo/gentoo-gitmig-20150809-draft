# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-primes/crypt-primes-0.50.ebuild,v 1.2 2003/10/28 01:27:21 brad_mssw Exp $

inherit perl-module

MY_P=Crypt-Primes-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Provable Prime Number Generator suitable for Cryptographic Applications."
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc ~amd64"

DEPEND="dev-perl/math-pari
		dev-perl/crypt-random"
