# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.30.ebuild,v 1.1 2004/06/11 13:42:03 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A perl XML down translate module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

SRC_TEST="do"

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/XML-LibXML
	dev-perl/Test-Simple
	>=dev-perl/XML-Parser-2.31"

src_compile() {
	echo "" | perl-module_src_compile
}
