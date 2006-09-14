# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.19.ebuild,v 1.1 2006/09/14 17:37:53 yuval Exp $

inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"
SRC_URI="mirror://cpan/authors/id/J/JA/JASLONG/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jaslong/${P}/"
DEPEND="dev-perl/Crypt-OpenSSL-Bignum
	dev-perl/Crypt-OpenSSL-RSA
		dev-perl/crypt-rsa
		dev-perl/Digest-SHA
		dev-perl/Digest-SHA1
		virtual/perl-MIME-Base64
		dev-perl/Net-DNS
		dev-perl/MailTools
		dev-perl/Error
	dev-lang/perl"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"


