# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SRU/SRU-0.97.ebuild,v 1.1 2008/12/23 08:13:02 robbat2 Exp $

MODULE_AUTHOR="BRICAS"

inherit perl-module

DESCRIPTION="Catalyst::Controller::SRU - Dispatch SRU methods with Catalyst"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Test-Exception
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/XML-Simple
	dev-perl/Class-Accessor
	>=dev-perl/CQL-Parser-1.0"
