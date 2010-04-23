# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Signature/Module-Signature-0.63.ebuild,v 1.1 2010/04/23 18:25:46 robbat2 Exp $

EAPI=2
MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Module signature file manipulation "

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

SRC_TEST="do"

DEPEND="virtual/perl-MIME-Base64
	dev-perl/PAR-Dist
		virtual/perl-IO-Compress
		dev-perl/crypt-cbc
		dev-perl/Crypt-DES
		dev-perl/Crypt-Blowfish
		dev-perl/Crypt-RIPEMD160
		dev-perl/class-loader
		dev-perl/tie-encryptedhash
		dev-perl/convert-ascii-armour
		dev-perl/data-buffer
		dev-perl/digest-md2
		>=dev-perl/math-pari-2.010603
		dev-perl/crypt-random
		dev-perl/crypt-primes
		dev-perl/crypt-des-ede3
		dev-perl/crypt-dsa
		dev-perl/crypt-rsa
		dev-perl/Convert-ASN1
		dev-perl/convert-pem
		dev-perl/Crypt-OpenPGP
	dev-lang/perl"

src_test() {
	use test && export TEST_SIGNATURE="1"
	perl-module_src_test
}
