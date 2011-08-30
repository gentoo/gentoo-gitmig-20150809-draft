# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DomainKeys/Mail-DomainKeys-1.0.0.ebuild,v 1.1 2011/08/30 10:52:07 tove Exp $

EAPI=4

MODULE_AUTHOR=ANTHONYU
MODULE_VERSION=1.0
inherit perl-module

DESCRIPTION="A perl implementation of DomainKeys"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-perl/Net-DNS-0.34
	dev-perl/MailTools
	dev-perl/Crypt-OpenSSL-RSA"
DEPEND="${RDEPEND}
	test? ( dev-perl/Email-Address )"

SRC_TEST="do"
