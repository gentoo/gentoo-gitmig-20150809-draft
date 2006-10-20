# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-rsa/crypt-rsa-1.57.ebuild,v 1.11 2006/10/20 14:53:11 mcummings Exp $

inherit perl-module

MY_P=Crypt-RSA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RSA public-key cryptosystem"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/math-pari-2.010603
	dev-perl/crypt-random
	dev-perl/Crypt-Blowfish
	dev-perl/Sort-Versions
	dev-perl/Digest-SHA1
	virtual/perl-Digest-MD5
	dev-perl/class-loader
	dev-perl/digest-md2
	dev-perl/convert-ascii-armour
	dev-perl/tie-encryptedhash
	dev-perl/crypt-primes
	dev-perl/data-buffer
	dev-perl/crypt-cbc
	dev-lang/perl"
