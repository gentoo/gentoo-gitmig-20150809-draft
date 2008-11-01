# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Response-Encoding/HTTP-Response-Encoding-0.05.ebuild,v 1.4 2008/11/01 17:58:25 nixnut Exp $

MODULE_AUTHOR=DANKOGAI
inherit perl-module

DESCRIPTION="Adds encoding() to HTTP::Response"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
