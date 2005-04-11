# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenPGP/Crypt-OpenPGP-1.03.ebuild,v 1.1 2005/04/11 17:00:08 mcummings Exp $

inherit perl-module

DESCRIPTION="Pure-Perl OpenPGP-compatible PGP implementation"
HOMEPAGE="http://search.cpan.org/~btrott/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

# Core dependancies are:
# >=Data-Buffer 0.04
# MIME-Base64
# Math-Pari
# Compress-Zlib
# LWP-UserAgent
# URI-Escape

RDEPEND=">=dev-perl/data-buffer-0.04
		dev-perl/MIME-Base64
		>=dev-perl/math-pari-2.010603*
		dev-perl/Compress-Zlib
		dev-perl/libwww-perl
		dev-perl/URI
		dev-perl/crypt-dsa 
		dev-perl/crypt-rsa
		dev-perl/crypt-idea
		dev-perl/Digest-MD5
		dev-perl/Crypt-DES_EDE3
		dev-perl/Digest-SHA1
		dev-perl/Crypt-Rijndael
		dev-perl/Crypt-CAST5_PP
		dev-perl/Crypt-RIPEMD160
		dev-perl/Crypt-Blowfish
		>=dev-perl/Crypt-Twofish-2.00
		dev-perl/ExtUtils-AutoInstall"
