# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-Any/JSON-Any-1.20.ebuild,v 1.1 2009/07/03 05:35:38 tove Exp $

EAPI=2
MODULE_AUTHOR="PERIGRIN"

inherit perl-module

DESCRIPTION="Wrapper Class for the various JSON classes."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/JSON"
RDEPEND="${DEPEND}"

SRC_TEST=do
