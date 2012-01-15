# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Search-Xapian/Search-Xapian-1.2.8.ebuild,v 1.2 2012/01/15 19:13:08 tove Exp $

EAPI=3

MODULE_AUTHOR=OLLY
MODULE_VERSION=1.2.8.0
inherit perl-module

DESCRIPTION="Perl XS frontend to the Xapian C++ search library."

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-libs/xapian-1.2.8"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"

src_install() {
	perl-module_src_install

	use examples && {
		docinto examples
		dodoc "${S}"/examples/*
	}
}
