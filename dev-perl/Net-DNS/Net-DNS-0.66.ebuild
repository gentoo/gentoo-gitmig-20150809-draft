# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.66.ebuild,v 1.3 2010/01/08 21:33:17 tove Exp $

EAPI=2

MODULE_AUTHOR=OLAF
inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 test"

RDEPEND="virtual/perl-Digest-MD5
	dev-perl/Digest-HMAC
	virtual/perl-Digest-SHA
	dev-perl/Net-IP
	ipv6? ( dev-perl/IO-Socket-INET6 )
	virtual/perl-MIME-Base64"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple
		dev-perl/Test-Pod )"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	mydoc="TODO"
	if use ipv6 ; then
		myconf="--IPv6-tests"
	else
		myconf="--no-IPv6-tests"
	fi
	myconf="${myconf} --no-online-tests"
}
