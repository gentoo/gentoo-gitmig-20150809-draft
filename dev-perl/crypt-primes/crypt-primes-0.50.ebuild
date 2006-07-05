# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-primes/crypt-primes-0.50.ebuild,v 1.12 2006/07/05 14:13:49 ian Exp $

inherit perl-module

MY_P=Crypt-Primes-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Provable Prime Number Generator suitable for Cryptographic Applications."
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/math-pari
	dev-perl/crypt-random"
RDEPEND="${DEPEND}"