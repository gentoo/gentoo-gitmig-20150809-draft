# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-moniker/UNIVERSAL-moniker-0.08.ebuild,v 1.14 2009/10/22 12:40:09 tove Exp $

MODULE_AUTHOR=KASEI
inherit perl-module

DESCRIPTION="adds a moniker to every class or module"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Lingua-EN-Inflect )"

SRC_TEST="do"
