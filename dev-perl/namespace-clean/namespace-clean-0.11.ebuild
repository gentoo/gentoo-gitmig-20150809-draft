# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.11.ebuild,v 1.1 2009/03/05 19:27:20 tove Exp $

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-perl/B-Hooks-EndOfScope-0.07"
DEPEND="${RDEPEND}"

SRC_TEST=do
