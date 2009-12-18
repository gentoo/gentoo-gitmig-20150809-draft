# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenPGP/Crypt-OpenPGP-1.04.ebuild,v 1.1 2009/12/18 03:22:50 robbat2 Exp $

inherit perl-module

DESCRIPTION="Pure-Perl OpenPGP-compatible PGP implementation"
HOMEPAGE="http://search.cpan.org/~btrott/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SRC_TEST="do"

# Core dependancies are:
# >=Data-Buffer 0.04
# MIME-Base64
# Math-Pari
# Compress-Zlib
# LWP-UserAgent
# URI-Escape

DEPEND=">=dev-perl/data-buffer-0.04
		virtual/perl-MIME-Base64
		>=dev-perl/math-pari-2.010603
		virtual/perl-IO-Compress
		dev-perl/libwww-perl
		dev-perl/URI
		dev-perl/crypt-dsa
		dev-perl/crypt-rsa
		dev-perl/crypt-idea
		virtual/perl-Digest-MD5
		dev-perl/crypt-des-ede3
		dev-perl/Digest-SHA1
		dev-perl/Crypt-Rijndael
		dev-perl/Crypt-CAST5_PP
		dev-perl/Crypt-RIPEMD160
		dev-perl/Crypt-Blowfish
		>=dev-perl/Crypt-Twofish-2.00
		dev-perl/ExtUtils-AutoInstall
	dev-lang/perl"
