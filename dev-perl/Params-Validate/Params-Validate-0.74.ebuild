# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.74.ebuild,v 1.6 2004/10/03 21:20:13 swegener Exp $

inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"
SRC_URI="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/"

SRC_TEST="do"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc alpha ~sparc"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Attribute-Handlers"

src_install () {

	perl-module_src_install
	dohtml htdocs/*

}
