# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.17.ebuild,v 1.1 2006/06/07 14:59:38 ian Exp $

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
		dev-perl/Error"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"
IUSE=""
SRC_TEST="do"
