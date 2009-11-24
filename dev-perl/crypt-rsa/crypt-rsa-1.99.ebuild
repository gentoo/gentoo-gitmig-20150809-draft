# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-rsa/crypt-rsa-1.99.ebuild,v 1.6 2009/11/24 19:54:01 klausman Exp $

EAPI=2

MODULE_AUTHOR=VIPUL
MY_PN=Crypt-RSA
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="RSA public-key cryptosystem"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc sparc x86"
IUSE=""

DEPEND="dev-perl/class-loader
	dev-perl/Crypt-Blowfish
	dev-perl/convert-ascii-armour
	dev-perl/crypt-cbc
	dev-perl/crypt-primes
	dev-perl/crypt-random
	dev-perl/data-buffer
	dev-perl/digest-md2
	virtual/perl-Digest-MD5
	dev-perl/Digest-SHA1
	>=dev-perl/math-pari-2.010603
	dev-perl/Sort-Versions
	dev-perl/tie-encryptedhash"
RDEPEND="${DEPEND}"

SRC_TEST="do"
