# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Grouped/Class-Accessor-Grouped-0.09004.ebuild,v 1.1 2010/08/15 06:54:29 tove Exp $

EAPI=3

MODULE_AUTHOR="RKITOVER"
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Class-Inspector
	dev-perl/Class-XSAccessor
	dev-perl/Sub-Identify
	dev-perl/Sub-Name
	dev-perl/MRO-Compat"
DEPEND="${RDEPEND}"

SRC_TEST=do
