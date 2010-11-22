# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-Any/JSON-Any-1.25.ebuild,v 1.1 2010/11/22 17:03:51 tove Exp $

EAPI=3

MODULE_AUTHOR="PERIGRIN"
inherit perl-module

DESCRIPTION="Wrapper Class for the various JSON classes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/JSON"
RDEPEND="${DEPEND}"

SRC_TEST=do
