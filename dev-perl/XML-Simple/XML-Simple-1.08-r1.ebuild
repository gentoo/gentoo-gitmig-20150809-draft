# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-1.08-r1.ebuild,v 1.7 2004/06/25 01:14:01 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl XML Simple package."
SRC_URI="http://www.cpan.org/authors/id/G/GR/GRANTM/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
