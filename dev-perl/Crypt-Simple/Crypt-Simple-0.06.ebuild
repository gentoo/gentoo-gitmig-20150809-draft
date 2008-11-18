# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Simple/Crypt-Simple-0.06.ebuild,v 1.6 2008/11/18 14:39:03 tove Exp $

inherit perl-module

DESCRIPTION="Crypt::Simple - encrypt stuff simply"
SRC_URI="mirror://cpan/authors/id/K/KA/KASEI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
IUSE="test"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SRC_TEST="do"
RDEPEND="dev-perl/FreezeThaw
	dev-lang/perl
	virtual/perl-Compress-Zlib
	dev-perl/Crypt-Blowfish
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	test? ( virtual/perl-Test-Harness )"
DEPEND="${RDEPEND}"
