# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS-Async/Net-DNS-Async-1.07.ebuild,v 1.3 2009/06/21 12:40:14 tove Exp $

MODULE_AUTHOR="SHEVEK"
inherit perl-module

DESCRIPTION="Asynchronous DNS helper for high volume applications"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Net-DNS"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_test() {
	# disable online test
	mv "${S}"/t/02_resolve.t{,.disable} || die
	perl-module_src_test
}
