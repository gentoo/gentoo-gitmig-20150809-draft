# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.32.ebuild,v 1.4 2008/11/20 16:13:57 jer Exp $

MODULE_AUTHOR=JASLONG
inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Crypt-OpenSSL-RSA-0.24
		virtual/perl-Digest-SHA
		virtual/perl-MIME-Base64
		dev-perl/Net-DNS
		dev-perl/MailTools
		dev-lang/perl"

SRC_TEST="do"

src_test(){
	# disable online tests
	for test in policy verifier ; do
		mv "${S}"/t/${test}.t{,.disable}
	done
	perl-module_src_test
}
