# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.34.ebuild,v 1.9 2004/06/08 20:09:07 lv Exp $

inherit perl-module

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha arm hppa amd64 ia64 s390"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1"
