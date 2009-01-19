# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.53.ebuild,v 1.1 2009/01/19 10:06:08 tove Exp $

MODULE_AUTHOR=AMBS
MODULE_SECTION=XML
inherit perl-module

DESCRIPTION="A perl XML down translate module"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

SRC_TEST="do"

RDEPEND=">=dev-perl/libwww-perl-1.35
	>=dev-perl/XML-LibXML-1.60
	>=dev-perl/XML-DTDParser-2.00
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
