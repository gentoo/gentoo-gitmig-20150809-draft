# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.59.ebuild,v 1.1 2003/06/16 14:17:30 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"
SRC_URI="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc "

DEPEND="${DEPEND}
	dev-perl/Attribute-Handlers"

mydoc="CREDITS UPGRADE"

src_install () {
	
	perl-module_src_install
    dohtml htdocs/*

}
