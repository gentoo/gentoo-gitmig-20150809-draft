# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM-XPath/XML-DOM-XPath-0.140.0.ebuild,v 1.1 2011/08/28 06:54:41 tove Exp $

EAPI=4

MODULE_AUTHOR=MIROD
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Perl extension to add XPath support to XML::DOM, using XML::XPath engine"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/XML-DOM
	dev-perl/XML-XPathEngine"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
