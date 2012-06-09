# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.590.0.ebuild,v 1.1 2012/06/09 10:00:27 tove Exp $

EAPI=4

MODULE_AUTHOR=AMBS
MODULE_SECTION=XML
MODULE_VERSION=0.59
inherit perl-module

DESCRIPTION="A perl XML down translate module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/libwww-perl-1.35
	>=dev-perl/XML-LibXML-1.60
	>=dev-perl/XML-DTDParser-2.00"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
