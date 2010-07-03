# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.38.ebuild,v 1.5 2010/07/03 15:37:10 armin76 Exp $

EAPI=2

MODULE_AUTHOR=JASLONG
inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-perl/Crypt-OpenSSL-RSA-0.24
	virtual/perl-Digest-SHA
	virtual/perl-MIME-Base64
	dev-perl/Net-DNS
	dev-perl/MailTools"
RDEPEND="${DEPEND}"

SRC_TEST="do"

src_test(){
	# disable online tests
	for test in policy public_key verifier ; do
		mv "${S}"/t/${test}.t{,.disable}
	done
	perl-module_src_test
}
