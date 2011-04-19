# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Domain-TLD/Net-Domain-TLD-1.690.0.ebuild,v 1.1 2011/04/19 17:06:12 tove Exp $

EAPI=4

MODULE_AUTHOR=ALEXP
MODULE_VERSION=1.69
inherit perl-module

DESCRIPTION="Current list of available top level domain names including new ICANN additions and ccTLDs"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
