# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Signature/Module-Signature-0.44.ebuild,v 1.2 2005/04/11 20:21:19 fmccor Exp $

inherit perl-module

DESCRIPTION="Module signature file manipulation "
HOMEPAGE="http://search.cpan.org/~autrijus/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/MIME-Base64
		dev-perl/Compress-Zlib
		dev-perl/crypt-cbc
		dev-perl/Crypt-DES
		dev-perl/Crypt-Blowfish
		dev-perl/Crypt-RIPEMD160
		dev-perl/class-loader
		dev-perl/tie-encryptedhash
		dev-perl/convert-ascii-armour
		dev-perl/data-buffer
		dev-perl/digest-md2
		>=dev-perl/math-pari-2.010603*
		dev-perl/crypt-random
		dev-perl/crypt-primes
		dev-perl/Crypt-DES_EDE3
		dev-perl/crypt-dsa
		dev-perl/crypt-rsa
		dev-perl/Convert-ASN1
		dev-perl/convert-pem
		dev-perl/Crypt-OpenPGP"
