# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-primes/crypt-primes-0.50.ebuild,v 1.7 2004/10/16 23:57:25 rac Exp $

inherit perl-module

MY_P=Crypt-Primes-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Provable Prime Number Generator suitable for Cryptographic Applications."
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64 ~mips"
IUSE=""

DEPEND="dev-perl/math-pari
	dev-perl/crypt-random"
