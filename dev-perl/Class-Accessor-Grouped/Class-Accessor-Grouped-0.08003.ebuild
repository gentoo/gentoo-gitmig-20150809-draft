# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Grouped/Class-Accessor-Grouped-0.08003.ebuild,v 1.1 2009/06/23 07:34:38 robbat2 Exp $

MODULE_AUTHOR="CLACO"
EAPI=2

inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Class-Inspector
	dev-perl/MRO-Compat"
DEPEND="${RDEPEND}"
