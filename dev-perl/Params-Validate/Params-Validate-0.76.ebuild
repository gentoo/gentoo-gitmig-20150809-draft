# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.76.ebuild,v 1.9 2005/08/26 00:01:51 agriffis Exp $

inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://search.perl.com/~drolsky/${P}/"

SRC_TEST="do"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

src_install () {

	perl-module_src_install
	dohtml htdocs/*

}
