# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.13.ebuild,v 1.1 2010/01/17 10:41:48 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Sub-Identify-0.04
	>=dev-perl/Sub-Name-0.04
	>=dev-perl/B-Hooks-EndOfScope-0.07"
DEPEND="${RDEPEND}"

SRC_TEST=do
