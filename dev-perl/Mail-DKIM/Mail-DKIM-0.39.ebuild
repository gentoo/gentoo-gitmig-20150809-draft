# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.39.ebuild,v 1.2 2011/03/30 09:32:04 xmw Exp $

EAPI=3

MODULE_AUTHOR=JASLONG
inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
