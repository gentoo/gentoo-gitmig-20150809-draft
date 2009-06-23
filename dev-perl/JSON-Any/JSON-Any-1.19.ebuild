# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-Any/JSON-Any-1.19.ebuild,v 1.1 2009/06/23 07:42:10 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="PERIGRIN"

inherit perl-module

DESCRIPTION="Wrapper Class for the various JSON classes."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/JSON"
RDEPEND="${DEPEND}"
