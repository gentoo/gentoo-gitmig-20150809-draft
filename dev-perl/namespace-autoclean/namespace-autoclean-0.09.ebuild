# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-autoclean/namespace-autoclean-0.09.ebuild,v 1.1 2009/10/10 11:05:40 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Keep imports out of your namespace"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/namespace-clean-0.11
	>=dev-perl/Class-MOP-0.80
	>=dev-perl/B-Hooks-EndOfScope-0.07
"
DEPEND="${RDEPEND}"
