# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DomainKeys/Mail-DomainKeys-1.0.ebuild,v 1.6 2010/01/10 17:02:49 grobian Exp $

MODULE_AUTHOR=ANTHONYU
inherit perl-module

DESCRIPTION="A perl implementation of DomainKeys"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

SRC_TEST="do"

RDEPEND=">=dev-perl/Net-DNS-0.34
	dev-perl/MailTools
	dev-perl/Crypt-OpenSSL-RSA
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Email-Address )"
