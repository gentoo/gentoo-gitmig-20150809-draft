# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SRU/SRU-0.99.ebuild,v 1.1 2009/12/10 08:03:18 tove Exp $

EAPI=2

MODULE_AUTHOR="BRICAS"
inherit perl-module

DESCRIPTION="Catalyst::Controller::SRU - Dispatch SRU methods with Catalyst"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/XML-Simple
	dev-perl/Class-Accessor
	>=dev-perl/CQL-Parser-1.0"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Exception )"

SRC_TEST=do
