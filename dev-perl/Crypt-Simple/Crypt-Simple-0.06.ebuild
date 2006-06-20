# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Simple/Crypt-Simple-0.06.ebuild,v 1.1 2006/06/20 12:50:13 ian Exp $

inherit perl-module

DESCRIPTION="Crypt::Simple - encrypt stuff simply"
SRC_URI="mirror://cpan/authors/id/K/KA/KASEI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
IUSE="test"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
SRC_TEST="do"
RDEPEND="dev-perl/FreezeThaw
	dev-perl/Compress-Zlib
	dev-perl/Crypt-Blowfish
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	test? ( virtual/perl-Test-Harness )"
DEPEND="${RDEPEND}"
