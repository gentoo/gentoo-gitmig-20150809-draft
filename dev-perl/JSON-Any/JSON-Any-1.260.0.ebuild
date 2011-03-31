# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-Any/JSON-Any-1.260.0.ebuild,v 1.1 2011/03/31 06:29:47 tove Exp $

EAPI=4

MODULE_AUTHOR=PERIGRIN
MODULE_VERSION=1.26
inherit perl-module

DESCRIPTION="Wrapper Class for the various JSON classes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/JSON"
RDEPEND="${DEPEND}"

SRC_TEST=do
