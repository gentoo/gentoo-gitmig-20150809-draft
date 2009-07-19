# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Simple/Crypt-Simple-0.06.ebuild,v 1.7 2009/07/19 17:37:29 tove Exp $

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
	virtual/perl-IO-Compress
	dev-perl/Crypt-Blowfish
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	test? ( virtual/perl-Test-Harness )"
DEPEND="${RDEPEND}"
